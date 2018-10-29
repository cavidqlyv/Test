using System.Runtime.Serialization;

namespace TMSService.Entities
{
    [DataContract]
    public class TMSCustomException
    {
        [DataMember]
        public string Title;
        [DataMember]
        public string ExceptionMessage;
        [DataMember]
        public string InnerException;
        [DataMember]
        public string StackTrace;  
    }
}
