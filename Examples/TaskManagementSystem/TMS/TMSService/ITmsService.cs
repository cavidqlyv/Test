using System.Collections.Generic;
using System.ServiceModel;
using TMSService.Entities;

namespace TMSService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "ITmsService" in both code and config file together.
    [ServiceContract]
    public interface ITmsService
    {
        [OperationContract]
        [FaultContract(typeof(TMSCustomException))]
        List<Priority> GetPriority();

        [OperationContract]
        [FaultContract(typeof(TMSCustomException))]
        List<Status> GetStatus();

        [OperationContract]
        [FaultContract(typeof(TMSCustomException))]
        List<Resource> GetResource();

        [OperationContract]
        [FaultContract(typeof(TMSCustomException))]
        List<Task> GetTaskList();

        [OperationContract]
        [FaultContract(typeof(TMSCustomException))]
        int SaveTask(Task task, bool isInsert);
       
    }   
}
