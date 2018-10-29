using System.Runtime.Serialization;
using System;

namespace TMSService.Entities
{
   [DataContract]
   public class Task
    {
       [DataMember]
        public int TaskID { get; set; }
       [DataMember]
        public string TaskName { get; set; }
       [DataMember]
        public int PriorityID { get; set; }
       [DataMember]
        public string PriorityName { get; set; }
       [DataMember]
        public int StatusID { get; set; }
       [DataMember]
        public string StatusName { get; set; }
       [DataMember]
        public int UserID { get; set; }
       [DataMember]
        public string UserName { get; set; }
       [DataMember]
        public DateTime CreatedOn { get; set; }
       [DataMember]
        public int EstimatedTime { get; set; }
       [DataMember]
        public int? ActualTime { get; set; }
       [DataMember]
        public int? ExtraTime { get; set; }
       [DataMember]
        public string Flag { get; set; }
    }
}
