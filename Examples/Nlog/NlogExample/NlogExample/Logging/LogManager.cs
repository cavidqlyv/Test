using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using NLog.Config;
using NLog.Targets;

namespace NlogExample.Logging
{
    public static class LogManager
    {
        private static readonly IDictionary<string, ILogger> Loggers = new Dictionary<string, ILogger>();

        private static ILogger GetLogger(Type type)
        {
            return GetLogger(type.Name);
        }

        public static ILogger GetLogger(object obj)
        {
            return GetLogger(obj.GetType());
        }

        public static ILogger GetLogger(string name)
        {
            if (!Configured)
                return new Logger(name, NLog.LogManager.CreateNullLogger());

            if (!Loggers.ContainsKey(name))
                Loggers.Add(name, new Logger(name));
            return Loggers[name];
        }

        private static bool Configured => NLog.LogManager.Configuration != null;

        public static void Configure(string logFile = "logs.log", string errorLogFile = "errors.log", LogLevel level = LogLevel.Info)
        {
            var path = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location) + @"\LogExample";
            if (!System.IO.Directory.Exists(path)) System.IO.Directory.CreateDirectory(path);
         
            Configure(path, logFile, errorLogFile, level);
        }

        private static void Configure(string appDir, string logFile = "logs.log", string errorLogFile = "errors.log", LogLevel level = LogLevel.Info)
        {
            appDir = Path.Combine(appDir, "My application logs");
            if (!Directory.Exists(appDir))
                Directory.CreateDirectory(appDir);


            LoggingConfiguration loggingConf = new LoggingConfiguration();
            
            var mainTarget = new FileTarget();
            loggingConf.AddTarget("file", mainTarget);
            mainTarget.FileName = Path.Combine(appDir, logFile);
            mainTarget.Layout = "${machinename}|${windows-identity}|${longdate}|${level:uppercase=true}|${logger}|${message}";
            mainTarget.ArchiveDateFormat = "yyyy-MM-dd-HH-mm";
            mainTarget.ArchiveFileName = Path.Combine(appDir + "\\archive", GetArchiveLogfileName(logFile));
            mainTarget.ArchiveEvery = FileArchivePeriod.Day;
            mainTarget.ArchiveNumbering = ArchiveNumberingMode.Date;
            mainTarget.MaxArchiveFiles = 8;
           
            var exceptionTarget = new FileTarget();
            loggingConf.AddTarget("file", exceptionTarget);
            exceptionTarget.FileName = Path.Combine(appDir, errorLogFile);
            exceptionTarget.Layout = "${machinename}|${windows-identity}|${longdate}|${level:uppercase=true}|${logger}|${message}|${exception:format=toString}";
            exceptionTarget.ArchiveDateFormat = "yyyy-MM-dd-HH-mm";
            exceptionTarget.ArchiveFileName = Path.Combine(appDir + "\\archive", GetArchiveLogfileName(errorLogFile));
            exceptionTarget.ArchiveEvery = FileArchivePeriod.Day;
            exceptionTarget.ArchiveNumbering = ArchiveNumberingMode.Date;
            exceptionTarget.MaxArchiveFiles = 8;

            var consoleTarget = new ColoredConsoleTarget();
            loggingConf.AddTarget("console", consoleTarget);
            consoleTarget.Layout = "${date:format=HH\\:mm\\:ss}|${level:uppercase=true}|${logger}|${message}";


            var mainRule = new LoggingRule("*", Logger.Convert(level), mainTarget);
            loggingConf.LoggingRules.Add(mainRule);

            var exceptionsRule = new LoggingRule("*", NLog.LogLevel.Warn, exceptionTarget);
            loggingConf.LoggingRules.Add(exceptionsRule);

            var consoleRule = new LoggingRule("*", Logger.Convert(level), consoleTarget);
            loggingConf.LoggingRules.Add(consoleRule);

            NLog.LogManager.Configuration = loggingConf;
        }

        private static string GetArchiveLogfileName(string logFile)
        {
            var tmp = logFile.Split('.');
            var archLogFile = tmp[0] + ".{#}." + tmp[1];
            return archLogFile;
        }

    }
}