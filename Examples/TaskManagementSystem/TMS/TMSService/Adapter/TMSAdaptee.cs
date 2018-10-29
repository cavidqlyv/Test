using System.Data.Objects;
using TMSDataService;
using TMSDataService.DataAccessStrategy.Components;

namespace TMSService.Adapter
{
    public class TMSAdaptee
    {
        IDataService dataService = null;

        public ObjectResult<tblPriority> GetPriority()
        {
            dataService = new DataService();
            return dataService.GetPriority();
        }

        public ObjectResult<tblStatu> GetStatus()
        {
            dataService = new DataService();
            return dataService.GetStatus();
        }

        public ObjectResult<tblUser> GetUser()
        {
            dataService = new DataService();
            return dataService.GetUser();
        }

        public ObjectResult<TaskList> GetTaskList()
        {
            dataService = new DataService();
            return dataService.GetTaskList();
        }

        public int SaveTask(tblTaskActivity task, bool isInsert)
        {
            dataService = new DataService();
            return dataService.SaveTask(task, isInsert);
        }
    }
}
