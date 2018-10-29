using System;
using System.Collections.Generic;
using TMSView.TmsServiceReference;

namespace TMSView.TmsViewService
{
    public class TmsClientService
    { 
        public List<Priority> GetPriority()
        {
            using (TmsServiceClient client = new TmsServiceClient())
            {
                try
                {
                    return client.GetPriority();
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
            }
        }

        public List<Status> GetStatus()
        {
            using (TmsServiceClient client = new TmsServiceClient())
            {
                try
                {
                    return client.GetStatus();
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
            }
        }

        public List<Resource> GetResource()
        {
            using (TmsServiceClient client = new TmsServiceClient())
            {
                try
                {
                    return client.GetResource();
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
            }
        }

        public List<Task> GetTaskList()
        {
            using (TmsServiceClient client = new TmsServiceClient())
            {
                try
                {
                    return client.GetTaskList();
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
            }
        }

        public int SaveTask(Task task, bool isInsert)
        {
            using (TmsServiceClient client = new TmsServiceClient())
            {
                try
                {
                    return client.SaveTask(task, isInsert);
                }
                catch (Exception)
                {
                    client.Abort();
                    throw;
                }
            }
        }
    }
}