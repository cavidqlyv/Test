using System.Collections.Generic;
using TMSDataService.DataAccessStrategy.Components;
using TMSService.Entities;

namespace TMSService.Adapter
{
    public class TMSAdapter : ITMS
    {
        public List<Priority> GetPriority()
        {
            //Obtain the data from Adaptee
            var lstPriorityData = adaptee.GetPriority();

            var lstPriorities = new List<Priority>();

            lstPriorities.Add(new Priority { PriorityID = -1, PriorityName = "--Select--" });

            //Do the transformation
            foreach (tblPriority p in lstPriorityData)
            {
                lstPriorities.Add(new Priority
                {
                     PriorityID = p.PriorityID
                     , PriorityName = p.PriorityName
                });
            }

            return lstPriorities;
        }

        public List<Status> GetStatus()
        {
            //Obtain the data from Adaptee
            var lstStatusData = adaptee.GetStatus();

            var lstStatus = new List<Status>();

            lstStatus.Add(new Status { StatusID = -1, StatusName = "--Select--" });

            //Do the transformation
            foreach (tblStatu s in lstStatusData)
            {
                lstStatus.Add(new Status
                {
                   StatusID = s.StatusID
                   , StatusName = s.StatusName
                });
            }

            return lstStatus;
        }

        public List<Resource> GetResource()
        {
            //Obtain the data from Adaptee
            var lstUserData = adaptee.GetUser();

            var lstResources = new List<Resource>();

            lstResources.Add(new Resource { ResourceID = -1, ResourceName = "--Select--" });

            //Do the transformation
            foreach (tblUser u in lstUserData)
            {
                lstResources.Add(new Resource
                {
                     ResourceID = u.UserID
                     , ResourceName = u.UserName
                });
            }

            return lstResources;
        }

        public List<Task> GetTaskList()
        {
            //Obtain the data from Adaptee
            var lstTaskData = adaptee.GetTaskList();

            var lstTasks = new List<Task>();

            //Do the transformation
            foreach (TaskList t in lstTaskData)
            {
                lstTasks.Add(new Task
                {
                    TaskID = t.TaskId
                    ,
                    TaskName = t.TaskName
                    ,
                    PriorityID = t.PriorityID
                   ,
                    PriorityName = t.PriorityName
                    ,
                    StatusID = t.StatusID
                   ,
                    StatusName = t.StatusName
                    ,
                    UserID = t.UserID
                   ,
                    UserName = t.UserName
                    ,
                    CreatedOn = t.TaskCreatedOn
                    ,
                    EstimatedTime = t.EstimatedTime
                    ,
                    ActualTime = t.ActualTime
                    ,
                    ExtraTime = t.EstimatedTime - t.ActualTime
                    ,
                    Flag = string.Empty
                    
                });
            }

            return lstTasks;
        }

        public int SaveTask(Task task, bool isInsert)
        {
            //throw new NotImplementedException();
            tblTaskActivity taskActivity = new tblTaskActivity();

            taskActivity.TaskID = task.TaskID;
            taskActivity.TaskName = task.TaskName;
            taskActivity.Priority =  task.PriorityID;
            taskActivity.Status = task.StatusID;
             taskActivity.AssignedTo = task.UserID;
            taskActivity.TaskCreatedOn =  task.CreatedOn;
            taskActivity.EstimatedTime =  task.EstimatedTime;
            taskActivity.ActualTime = task.ActualTime;
            return adaptee.SaveTask(taskActivity, isInsert);
        }

        private TMSAdaptee adaptee = new TMSAdaptee();
    }
}
