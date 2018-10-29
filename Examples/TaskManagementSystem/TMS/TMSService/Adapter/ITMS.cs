using System.Collections.Generic;
using TMSService.Entities;

namespace TMSService.Adapter
{
    public interface ITMS
    {
        List<Priority> GetPriority();
        List<Status> GetStatus();
        List<Resource> GetResource();
        List<Task> GetTaskList();
        int SaveTask(Task task, bool isInsert);
    }
}
