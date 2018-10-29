using System;
using System.Xml.Serialization;
using System.Collections;

namespace SoftwareMonkeys.WorkHub.Configuration
{
	/// <summary>
	/// Holds the current configuration settings used for backend operations.
	/// </summary>
    //[XmlType(Namespace = "SoftwareMonkeys.WorkHub.Configuration")]
    //[XmlRoot(Namespace = "SoftwareMonkeys.WorkHub.Configuration")]
	public class AppConfig : BaseConfig, IAppConfig
	{
        private string title;
        /// <summary>
        /// Gets/sets the title of the application.
        /// </summary>
        public string Title
        {
            get { return title; }
            set { title = value; }
        }

        #region IAppConfig Members
        private int sessionTimeout;
        /// <summary>
        /// Gets/sets the session timeout for authentication.
        /// </summary>
        public int SessionTimeout
        {
            get { return sessionTimeout; }
            set { sessionTimeout = value; }
        }

        private string applicationPath;
        /// <summary>
        /// Gets the virtual application path.
        /// </summary>
        public string ApplicationPath
        {
            get { return applicationPath; }
            set { applicationPath = value; }
        }

        private string physicalApplicationPath;
        /// <summary>
        /// Gets/sets the physical path of the application.
        /// </summary>
        public string PhysicalApplicationPath
        {
            get { return physicalApplicationPath; }
            set { physicalApplicationPath = value; }
        }

        private Guid universalProjectID;
        /// <summary>
        /// Gets/sets the universal ID of the project.
        /// </summary>
        public Guid UniversalProjectID
        {
            get { return universalProjectID; }
            set { universalProjectID = value; }
        }
        
        private Guid primaryAdministratorID;
        /// <summary>
        /// Gets/sets the universal ID of the project.
        /// </summary>
        public Guid PrimaryAdministratorID
        {
            get { return primaryAdministratorID; }
            set { primaryAdministratorID = value; }
        }
        
        private string smtpServer;
        /// <summary>
        /// Gets/sets the SMTP server to use for sending emails.
        /// </summary>
        public string SmtpServer
        {
        	get { return smtpServer; }
        	set { smtpServer = value; }
        }
        
    	private string pathVariation;
        /// <summary>
        /// Gets/sets the variation applied to the config file path (eg. staging, local, etc.).
        /// </summary>
        public string PathVariation
        {
        	get { return pathVariation; }
        	set { pathVariation = value; }
        }

        /// <summary>
        /// Gets/sets the flexible settings collection.
        /// </summary>
        [XmlIgnore]
        IConfigurationDictionary IAppConfig.Settings
        {
            get {
            	return this.Settings; }
        	set { this.Settings = new ConfigurationDictionary(value); }
        }
        
        private ConfigurationDictionary settings = new ConfigurationDictionary();
        /// <summary>
        /// Gets/sets the flexible settings collection.
        /// </summary>
        public ConfigurationDictionary Settings
        {
            get {
            	if (settings == null)
            		settings = new ConfigurationDictionary();
            	return settings; }
            set { settings = value; }
        }
        #endregion
        
        public AppConfig()
        {
        	Name = "Application";
        }
        
        /// <summary>
        /// Gets/sets the IDs of the enabled modules.
        /// </summary>
        [XmlIgnore]
        public string[] EnabledModules
        {
        	get {
        		if (Settings.ContainsKey("EnabledModules"))
        			return Settings.GetString("EnabledModules").Split(',');
        		else
        			return new string[]{};
        	}
        	set { Settings["EnabledModules"] = String.Join(",", value); }
        }	
    }
}
