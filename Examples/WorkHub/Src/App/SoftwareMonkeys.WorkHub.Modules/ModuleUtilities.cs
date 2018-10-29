using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Reflection;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules;
using System.IO;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Business
{
	/// <summary>
	/// Description of ModuleUtilities.
	/// </summary>
	public static class ModuleUtilities
	{


        static public string[] GetLegacyModules(string dataPath)
        {
            List<string> list = new List<string>();

            using (LogGroup logGroup = LogGroup.Start("Retrieving the original legacy modules.", NLog.LogLevel.Debug))
            {
                foreach (string directory in Directory.GetDirectories(dataPath))
                {
                    if (directory.IndexOf(".Modules.") > -1)
                    {
                        LogWriter.Debug("Found module data directory: " + directory);

                        string module = String.Empty;
                        string nspace = Path.GetFileName(directory);
                        string[] parts = nspace.Split('.');

                        module = parts[3]; // Position 4 (index=3)

                        LogWriter.Debug("part 0: " + parts[0]);
                        LogWriter.Debug("part 1: " + parts[1]);
                        LogWriter.Debug("part 2: " + parts[2]);
                        LogWriter.Debug("part 3: " + parts[3]);
                        LogWriter.Debug("part 4: " + parts[4]);

                        if (!list.Contains(module))
                        {
                            list.Add(module);
                            LogWriter.Debug("Added module to list: " + module);
                        }
                        else
                            LogWriter.Debug("Module already in list.");
                    }
                }
            }

            return list.ToArray();
        }

	}
}
