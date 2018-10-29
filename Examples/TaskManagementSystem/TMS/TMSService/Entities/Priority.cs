using System.Runtime.Serialization;

namespace TMSService.Entities
{
    [DataContract]
    public class Priority
    {
        [DataMember]
        public int PriorityID { get; set; }
        [DataMember]
        public string PriorityName { get; set; }
    }
}
