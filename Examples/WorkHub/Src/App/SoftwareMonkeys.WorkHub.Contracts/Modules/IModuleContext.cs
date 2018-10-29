using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Modules
{
    /// <summary>
    /// Defines the interface of all module context components.
    /// </summary>
    public interface IModuleContext : IEntity
    {		
    	/// <summary>
    	/// Enables the module and initializes it ready for use.
    	/// </summary>
        void Enable();
        
        /// <summary>
        /// Disables the module and removes it from the system.
        /// </summary>
        void Disable();
        
        /// <summary>
        /// Handles the provided event and triggers the appropriate business functions.
        /// </summary>
        /// <param name="ev">The entity event to handle.</param>
        void HandleEvent(IEntityEvent ev);
    }
}
