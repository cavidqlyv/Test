using System.Collections.Generic;
using TMSService.Entities;

namespace TMSService.Adapter
{
    public class TMSClient
    {
        public List<Priority> GetPriority(ITMS tms)
        {
            return tms.GetPriority();
        }

        public List<Status> GetStatus(ITMS tms)
        {
            return tms.GetStatus();
        }

        public List<Resource> GetResource(ITMS tms)
        {
            return tms.GetResource();
        }

        public List<Task> GetTaskList(ITMS tms)
        {
            return tms.GetTaskList();
        }

        public int SaveTask(Task task, bool isInsert,ITMS tms)
        {
            return tms.SaveTask(task, isInsert);
        }
    }
}
