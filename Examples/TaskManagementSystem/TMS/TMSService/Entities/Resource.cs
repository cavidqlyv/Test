using System.Runtime.Serialization;

namespace TMSService.Entities
{
   [DataContract]
   public class Resource
    {
        [DataMember]
        public int ResourceID { get; set; }
        [DataMember]
        public string ResourceName { get; set; }
    }
}
