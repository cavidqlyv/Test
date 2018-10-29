using System;
using System.Collections.Generic;
using System.ComponentModel.Composition;
using System.ComponentModel.Composition.Hosting;
using System.Data.Objects;
using System.Reflection;
using TMSDataService.DataAccessStrategy.Components;
using TMSDataService.DataAccessStrategy.Contract;

namespace TMSDataService.DataAccessStrategy.CompositionHelper
{
    public class TMSCompositionHelper : IDisposable
    {
        [ImportMany]
        public System.Lazy<IDataAccess, IDictionary<string, object>>[] DataPlugins { get; set; }

        /// <summary>
        /// Assembles the data components
        /// </summary>
        public void AssembleDataComponents()
        {
            try
            {
                //Step 1: Initializes a new instance of the 
                //        System.ComponentModel.Composition.Hosting.AssemblyCatalog class with the 
                //        current executing assembly.
                var catalog = new AssemblyCatalog(Assembly.GetExecutingAssembly());

                //Step 2: The assemblies obtained in step 1 are added to the CompositionContainer
                var container = new CompositionContainer(catalog);

                //Step 3: Composable parts are created here i.e. the Import and Export components 
                //        assembles here
                container.ComposeParts(this);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// GetPriority
        /// </summary>
        /// <param name="dataSourceType"></param>
        /// <returns></returns>
        public ObjectResult<tblPriority> GetPriority(string dataSourceType)
        {
            ObjectResult<tblPriority> lstPriority = null;

            foreach (var dataPlugin in DataPlugins)
            {
                if ((string)dataPlugin.Metadata["TMSModelSQLMetaData"] == dataSourceType)
                {
                    lstPriority = dataPlugin.Value.GetPriority();
                    break;
                }
            }
            return lstPriority;
        }


        /// <summary>
        /// GetStatus
        /// </summary>
        /// <param name="dataSourceType"></param>
        /// <returns></returns>
        public ObjectResult<tblStatu> GetStatus(string dataSourceType)
        {
            ObjectResult<tblStatu> lstStatus = null;

            foreach (var dataPlugin in DataPlugins)
            {
                if ((string)dataPlugin.Metadata["TMSModelSQLMetaData"] == dataSourceType)
                {
                    lstStatus = dataPlugin.Value.GetStatus();
                    break;
                }
            }
            return lstStatus;
        }


        /// <summary>
        /// GetUser
        /// </summary>
        /// <param name="dataSourceType"></param>
        /// <returns></returns>
        public ObjectResult<tblUser> GetUser(string dataSourceType)
        {
            ObjectResult<tblUser> lstUser = null;

            foreach (var dataPlugin in DataPlugins)
            {
                if ((string)dataPlugin.Metadata["TMSModelSQLMetaData"] == dataSourceType)
                {
                    lstUser = dataPlugin.Value.GetUser();
                    break;
                }
            }
            return lstUser;
        }

        /// <summary>
        /// GetTaskList
        /// </summary>
        /// <param name="dataSourceType"></param>
        /// <returns></returns>
        public ObjectResult<TaskList> GetTaskList(string dataSourceType)
        {
            ObjectResult<TaskList> lstTaskList = null;

            foreach (var dataPlugin in DataPlugins)
            {
                if ((string)dataPlugin.Metadata["TMSModelSQLMetaData"] == dataSourceType)
                {
                    lstTaskList = dataPlugin.Value.GetTaskList();
                    break;
                }
            }
            return lstTaskList;
        }

        public int SaveTask(tblTaskActivity task, bool isInsert, string dataSourceType)
        {
            int TaskId = 0;

            foreach (var dataPlugin in DataPlugins)
            {
                if ((string)dataPlugin.Metadata["TMSModelSQLMetaData"] == dataSourceType)
                {
                    TaskId = dataPlugin.Value.SaveTask(task, isInsert);
                    break;
                }
            }

            return TaskId;
          
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}
