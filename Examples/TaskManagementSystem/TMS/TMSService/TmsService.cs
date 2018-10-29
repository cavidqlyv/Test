using System;
using System.Collections.Generic;
using System.ServiceModel;
using TMSService.Adapter;
using TMSService.Entities;

namespace TMSService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "TmsService" in both code and config file together.
    public class TmsService : ITmsService
    {
        public List<Priority> GetPriority()
        {
            List<Priority> lstPriorities = new List<Priority>();

            try
            {
                TMSClient client = new TMSClient();
                ITMS tmsAdapter = new TMSAdapter();
                lstPriorities = client.GetPriority(tmsAdapter);
            }
            catch (Exception e)
            {
                TMSCustomException ex = new TMSCustomException();
                ex.Title = e.Source;
                ex.ExceptionMessage = e.Message;
                ex.InnerException = e.InnerException.Message;
                ex.StackTrace = e.StackTrace;
                throw new FaultException<TMSCustomException>(ex);

            }
            return lstPriorities;  
        }

        public List<Status> GetStatus()
        {
            List<Status> lstStatus = new List<Status>();

            try
            {
                TMSClient client = new TMSClient();
                ITMS tmsAdapter = new TMSAdapter();
                lstStatus = client.GetStatus(tmsAdapter);
            }
            catch (Exception e)
            {
                TMSCustomException ex = new TMSCustomException();
                ex.Title = e.Source;
                ex.ExceptionMessage = e.Message;
                ex.InnerException = e.InnerException.Message;
                ex.StackTrace = e.StackTrace;
                throw new FaultException<TMSCustomException>(ex);

            }
            return lstStatus; 
        }

        public List<Resource> GetResource()
        {
            List<Resource> lstResource = new List<Resource>();

            try
            {
                TMSClient client = new TMSClient();
                ITMS tmsAdapter = new TMSAdapter();
                lstResource = client.GetResource(tmsAdapter);
            }
            catch (Exception e)
            {
                TMSCustomException ex = new TMSCustomException();
                ex.Title = e.Source;
                ex.ExceptionMessage = e.Message;
                ex.InnerException = e.InnerException.Message;
                ex.StackTrace = e.StackTrace;
                throw new FaultException<TMSCustomException>(ex);

            }
            return lstResource; 
        }

        public List<Task> GetTaskList()
        {
            List<Task> lstTask = new List<Task>();

            try
            {
                TMSClient client = new TMSClient();
                ITMS tmsAdapter = new TMSAdapter();
                lstTask = client.GetTaskList(tmsAdapter);
            }
            catch (Exception e)
            {
                TMSCustomException ex = new TMSCustomException();
                ex.Title = e.Source;
                ex.ExceptionMessage = e.Message;
                ex.InnerException = e.InnerException.Message;
                ex.StackTrace = e.StackTrace;
                throw new FaultException<TMSCustomException>(ex);

            }
            return lstTask; 
        }

        public int SaveTask(Task task, bool isInsert)
        {
            int taskId = 0;

            try
            {
                TMSClient client = new TMSClient();
                ITMS tmsAdapter = new TMSAdapter();
                taskId = client.SaveTask(task,isInsert,tmsAdapter);
            }
            catch (Exception e)
            {
                TMSCustomException ex = new TMSCustomException();
                ex.Title = e.Source;
                ex.ExceptionMessage = e.Message;
                ex.InnerException = e.InnerException.Message;
                ex.StackTrace = e.StackTrace;
                throw new FaultException<TMSCustomException>(ex);

            }
            return taskId; 
        }
    }
}
