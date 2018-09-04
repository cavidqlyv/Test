using NlogExample.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace NlogExample
{
    class Program
    {
        static void Main(string[] args)
        {
            LogManager.Configure();

            LogManager.GetLogger(typeof(Program)).Info($"{"Main"} | {"Ali"} | ---------- New session is created ---------- ");

            LogManager.GetLogger(typeof(Program)).Error(new FaultException("UserName is empty"), "UserName is empty");

            LogManager.GetLogger(typeof(Program)).Error("User not found");

            LogManager.GetLogger(typeof(Program)).Info($"{"Main"} | {"Ali"} | ---------- New session is finished ---------- ");
        }
    }

}
