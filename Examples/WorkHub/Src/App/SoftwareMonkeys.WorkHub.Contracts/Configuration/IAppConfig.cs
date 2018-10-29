using System;
using System.Collections;
using System.Text;

namespace SoftwareMonkeys.WorkHub.Configuration
{
    public interface IAppConfig : IConfig
    {
        /// <summary>
        /// The title of the application.
        /// </summary>
        string Title { get;set;}

        /// <summary>
        /// The full physical path to the root of the application.
        /// </summary>
        string PhysicalApplicationPath { get;set; }

		/// <summary>
		/// The universal ID of the current project.
		/// </summary>
		Guid UniversalProjectID { get; }
		
		/// <summary>
		/// The primary administrator ID.
		/// </summary>
        Guid PrimaryAdministratorID { get;set; }

        int SessionTimeout { get;set; }

        string ApplicationPath { get; set; }
        
        IConfigurationDictionary Settings { get;set; }
        
        string[] EnabledModules {get;set;}

    }
}
