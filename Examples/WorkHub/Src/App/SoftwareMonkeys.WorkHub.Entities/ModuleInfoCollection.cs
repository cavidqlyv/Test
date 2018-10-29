using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Entities
{
	public class ModuleInfoCollection : List<ModuleInfo>
	{
		private bool storeState = false;
		public bool StoreState
		{
			get { return storeState; }
		}
		
		public ModuleInfoCollection()
		{

        }

        public ModuleInfoCollection(ModuleInfo[] modules)
        {
            if (modules != null)
            {
                foreach (ModuleInfo module in modules)
                    Add(module);
            }
        }
		
		public ModuleInfoCollection(bool storeState)
		{
			this.storeState = storeState;
		}
		
		/// <summary>
		/// Gets/sets the module configuration object with the provided name.
		/// </summary>
		/// <param name="name">The name of the module.</param>
		/// <returns>The module with the provided name.</returns>
		public ModuleInfo this[string moduleID]
		{
			get
			{
				if (!StoreState)
				{
					foreach (ModuleInfo module in this)
                        if (module.ModuleID == moduleID)
                            return module;

					return null;
				}
				else
                    return (ModuleInfo)StateAccess.State.GetApplication("Module_" + moduleID);
			}
			set
			{
				if (!StoreState)
				{
					if (value == null)
					{
						for (int i = 0; i < Count; i++)
						{
                            if (this[i].ModuleID == moduleID)
								RemoveAt(i);
						}
					}
					else
					{
						for (int i = 0; i < Count; i++)
						{
                            if (this[i].ModuleID == moduleID)
							{
								this[i] = value;
							}
						}
					}
				}
				else
					StateAccess.State.SetApplication("Module_" + moduleID, value);
			}
		}

		/// <summary>
		/// Checks whether the specified module exists in the collection.
		/// </summary>
		/// <param name="name">The name of the module to check for.</param>
		/// <returns>A flag indicating whether the module was fond.</returns>
		public bool Contains(string moduleID)
		{
			if (StoreState)
			{
                return StateAccess.State.GetApplication("Module_" + moduleID) != null;
			}
			else
			{
				foreach (ModuleInfo config in this)
                    if (config.ModuleID == moduleID)
					return true;
				return false;
			}
		}

		/* /// <summary>
        /// Commits all the module configurations to file.
        /// </summary>
        public void Commit()
        {
            throw new NotImplementedException();
        }*/

        public void Add(ModuleInfo module)
        {
            base.Add(module);

            if (StoreState)
                StateAccess.State.SetApplication("Module_" + module.ModuleID, module);
        }
	}
}
