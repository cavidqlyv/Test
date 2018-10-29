using System.Data.Objects;
using TMSDataService.DataAccessStrategy.Components;
using TMSDataService.DataAccessStrategy.CompositionHelper;

namespace TMSDataService
{
    public class DataService : IDataService
    {
        string dataSourceType = "SQLSERVER";

        public ObjectResult<tblPriority> GetPriority()
        {
            using (TMSCompositionHelper objCompositionFactory = new TMSCompositionHelper())
            {
                //Assembles the calculator components that will participate in composition
                objCompositionFactory.AssembleDataComponents();

                //Gets the result
                var result = objCompositionFactory.GetPriority(dataSourceType);

                return result;
            }
        }


        public ObjectResult<tblStatu> GetStatus()
        {
            using (TMSCompositionHelper objCompositionFactory = new TMSCompositionHelper())
            {
                //Assembles the calculator components that will participate in composition
                objCompositionFactory.AssembleDataComponents();

                //Gets the result
                var result = objCompositionFactory.GetStatus(dataSourceType);

                return result;
            }
        }

        public ObjectResult<tblUser> GetUser()
        {
            using (TMSCompositionHelper objCompositionFactory = new TMSCompositionHelper())
            {
                //Assembles the calculator components that will participate in composition
                objCompositionFactory.AssembleDataComponents();

                //Gets the result
                var result = objCompositionFactory.GetUser(dataSourceType);

                return result;
            }
        }

        public ObjectResult<TaskList> GetTaskList()
        {
            using (TMSCompositionHelper objCompositionFactory = new TMSCompositionHelper())
            {
                //Assembles the calculator components that will participate in composition
                objCompositionFactory.AssembleDataComponents();

                //Gets the result
                var result = objCompositionFactory.GetTaskList(dataSourceType);

                return result;
            }
        }

        public int SaveTask(tblTaskActivity task, bool isInsert)
        {
            using (TMSCompositionHelper objCompositionFactory = new TMSCompositionHelper())
            {
                //Assembles the calculator components that will participate in composition
                objCompositionFactory.AssembleDataComponents();

                //Gets the result
                var result = objCompositionFactory.SaveTask(task, isInsert,dataSourceType);

                return result;
            }
        }
    }
}
