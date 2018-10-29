using System.Runtime.Serialization;

namespace TMSService.Entities
{
   [DataContract]
   public class Status
    {
        [DataMember]
        public int StatusID { get; set; }
        [DataMember]
        public string StatusName { get; set; }
    }
}
