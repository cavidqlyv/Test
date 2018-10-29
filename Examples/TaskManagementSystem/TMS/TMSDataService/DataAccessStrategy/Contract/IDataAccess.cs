using System.Data.Objects;
using TMSDataService.DataAccessStrategy.Components;

namespace TMSDataService.DataAccessStrategy.Contract
{
    public interface IDataAccess
    {
        ObjectResult<tblPriority> GetPriority();
        ObjectResult<tblStatu> GetStatus();
        ObjectResult<tblUser> GetUser();
        ObjectResult<TaskList> GetTaskList();
        int SaveTask(tblTaskActivity task, bool isInsert);
    }
}
