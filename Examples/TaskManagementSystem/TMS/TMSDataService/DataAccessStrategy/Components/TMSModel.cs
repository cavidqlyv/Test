using System.ComponentModel.Composition;
using System.Data.Objects;
using System.Linq;
using TMSDataService.DataAccessStrategy.Contract;

namespace TMSDataService.DataAccessStrategy.Components
{
    [Export(typeof(IDataAccess))]
    [ExportMetadata("TMSModelSQLMetaData", "SQLSERVER")]
    public class TMSModel : IDataAccess
    {
        public ObjectResult<tblPriority> GetPriority()
        {
            //Access the entity model from here
            var tmsEntities = new TMSEntities();
            return tmsEntities.GetPriority();
        }


        public ObjectResult<tblStatu> GetStatus()
        {
            //Access the entity model from here
            var tmsEntities = new TMSEntities();
            return tmsEntities.GetStatus();
        }

        public ObjectResult<tblUser> GetUser()
        {  
                //Access the entity model from here
            var tmsEntities = new TMSEntities();          
            return tmsEntities.GetUser();
        }

        public ObjectResult<TaskList> GetTaskList()
        {
            //Access the entity model from here
            var tmsEntities = new TMSEntities();
            return tmsEntities.GetTaskList();
        }


        public int SaveTask(tblTaskActivity task, bool isInsert)
        {
            int result = 0;

            using (var tmsEntities = new TMSEntities())
            {
            
                if (isInsert) //for insert
                {
                    tmsEntities.AddTotblTaskActivities(task);
                    result =  tmsEntities.SaveChanges();
                }
                else //for update
                {
                    var taskActivity = tmsEntities.tblTaskActivities.Where(i => i.TaskID == task.TaskID).FirstOrDefault();
                    taskActivity.Priority = task.Priority;
                    taskActivity.ActualTime = task.ActualTime;
                    result = tmsEntities.SaveChanges();
                }
            }
            return result;
        }
    }
}
