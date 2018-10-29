using System;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.WebControls;
using SoftwareMonkeys.WorkHub.Web.Properties;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.State;
using SoftwareMonkeys.WorkHub.Web;
using SoftwareMonkeys.WorkHub.Modules;

namespace SoftwareMonkeys.WorkHub.Web.State
{
    /// <summary>
    /// Provides facade logic related to projects.
    /// </summary>
    public class ProjectsState
    {
		/// <summary>
		/// Gets/sets a boolean value indicating whether the projects module is enabled.
		/// </summary>
		static public bool IsEnabled
		{
			get
			{
				bool isEnabled = false;
				using (LogGroup logGroup = LogGroup.Start("Checking whether the projects module is enabled.", NLog.LogLevel.Debug))
				{
					isEnabled = ModuleState.IsEnabled("Projects");
				}
				return isEnabled;
			}
		}

		/// <summary>
		/// Gets/sets a boolean value indicating whether a current project has been selected.
		/// </summary>
		static public bool ProjectSelected
		{
			get {
				return ProjectID != Guid.Empty;
			}
		}
		
    	public string Name
    	{
    		get { return this.GetType().Name; }
    	}
    	
        #region Singleton
        /// <summary>
        /// Gets/sets the ID of the project the user is currently working on.
        /// </summary>
        static public Guid ProjectID
        {
            get
            {
                Guid id = Guid.Empty;

                using (LogGroup logGroup = LogGroup.Start("Getting the ProjectsState.ProjectID property.", NLog.LogLevel.Debug))
                {
                	if (StateAccess.State.ContainsSession("Modules.Projects.ProjectID"))
	                    id = (Guid)StateAccess.State.GetSession("Modules.Projects.ProjectID");

                    LogWriter.Debug("Current project ID: " + id);
                }

                return id;
            }
            set
            {
                using (LogGroup logGroup = LogGroup.Start("Setting the ProjectsState.ProjectID property to: " + value, NLog.LogLevel.Debug))
                {
                    // If the session hasn't started yet skip this.
                    if (HttpContext.Current != null)
                    {
                    	object oldValue = null;
                		if (StateAccess.State.ContainsSession("Modules.Projects.ProjectID"))
                        	oldValue = StateAccess.State.GetSession("Modules.Projects.ProjectID");

                        if (!value.Equals(oldValue))
                        {
                            LogWriter.Debug("The new value is different from the old one.");

                            StateAccess.State.SetSession("Modules.Projects.ProjectID", value);
                            if (Project != null && Project.ID != value)
                            {
                                LogWriter.Debug("HttpContext.Current.Items[\"Project\"] is now set to null because it doesn't match the new ID.");
                                StateAccess.State.SetSession("Modules.Projects.Project", null);
                            }
                            RaiseProjectIDChanged();
                        }
                        else
                            LogWriter.Debug("The new value is the same as the original.");
                    }
                }
            }
        }

        /// <summary>
        /// Gets the project the user is currently working on.
        /// </summary>
        static public IProject Project
        {
            get
            {
                // If the session hasn't started yet skip this and return null.
                if (HttpContext.Current.Items == null)
                    return null;

                // TODO: This value maybe shouldn't be kept in session, only the ID should be
                if (HttpContext.Current.Items["Project"] == null)
                {
                	if (ProjectID != Guid.Empty)
                		HttpContext.Current.Items["Project"] = RetrieveStrategy.New("Project").Retrieve("ID", ProjectID);
                }
                return (IProject)HttpContext.Current.Items["Project"];
            }
            set
            {
                if (value == null)
                    ProjectID = Guid.Empty;
                else
                    ProjectID = value.ID;

            //    // If the session hasn't started yet skip this.
                if (HttpContext.Current.Items != null)
                    HttpContext.Current.Items["Project"] = value;
            }
        }

        /// <summary>
        /// Gets the name of the project that the user is currently working on.
        /// </summary>
        static public string ProjectName
        {
            get
            {
                if (Project != null)
                    return Project.Name;
                else
                    return String.Empty;
            }
        }

        /// <summary>
        /// Raises the ProjectIDChanged event.
        /// </summary>
        static protected void RaiseProjectIDChanged()
        {
            if (ProjectIDChanged != null)
                ProjectIDChanged(null, EventArgs.Empty);
        }

        /// <summary>
        /// Occurs after the current project ID has changed.
        /// </summary>
        static public event EventHandler ProjectIDChanged;
        #endregion

        /*static public string ProjectDirectory
        {
            get { return Config.Current.ProjectsDirectoryPath + "/" + My.Project.Name; }
        }*/

        #region Singleton functions
        /// <summary>
        /// Selects the project with the provided ID.
        /// </summary>
        /// <param name="project">The project to select.</param>
        static public void SelectProject(IProject project)
        {
            // Load the specified project
            Project = project;
        }
        #endregion

        /// <summary>
        /// Ensures that a project has been selected and that the ProjectID is not Guid.Empty. If a project has not been selected the user is redirected to the application home page.
        /// </summary>
        /// <returns>A flag indicating whether a project has been selected.</returns>
        static public bool EnsureProjectSelected()
        {
            if (ProjectID == Guid.Empty)
            {
                Result.DisplayError(Language.PleaseSelectProject);
             
                HttpContext.Current.Response.Redirect(UrlCreator.Current.CreateUrl("Index", "Project"));
                return false;
            }
            return true;
        }
        
        /// <summary>
        /// Ensures that the projects module has been enabled, otherwise redirects away from the page and displays a message.
        /// </summary>
        /// <returns>A boolean flag indicating whether the projects module has been enabled.</returns>
        static public bool EnsureProjectsEnabled()
        {
            if (!IsEnabled)
            {
                Result.DisplayError(Language.ProjectsModuleNotEnabled);
                HttpContext.Current.Response.Redirect("Default.aspx");
                return false;
            }
            return true;
        }
    }
}