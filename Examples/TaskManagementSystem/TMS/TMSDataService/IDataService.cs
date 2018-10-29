using System.Data.Objects;
using TMSDataService.DataAccessStrategy.Components;

namespace TMSDataService
{
    public interface IDataService
    {
        ObjectResult<tblPriority> GetPriority();
        ObjectResult<tblStatu> GetStatus();
        ObjectResult<tblUser> GetUser();
        ObjectResult<TaskList> GetTaskList();
        int SaveTask(tblTaskActivity task, bool isInsert);
    }
}
