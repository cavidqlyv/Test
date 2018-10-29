using System;
using System.Text;
using System.IO;

namespace InstallModule
{
    class Program
    {
        static void Main(string[] args)
        {
            string src = args[0];
            string dest = args[1];

            Console.WriteLine("Installing module from " + src + " to " + dest);

            // Skip SVN folders
            if (src.IndexOf(".svn") == -1 && src.IndexOf("_svn") == -1)
            {
                try
                {
                    if (!Directory.Exists(dest))
                        Directory.CreateDirectory(dest);

                    // Copy the files from the main module directory
                    foreach (string file in Directory.GetFiles(src + @"\Web\Projections", "*.ascx"))
                    {
                        // Make sure that the destination directory exists
                        if (!Directory.Exists(dest.TrimEnd('\\') + @"\Projections"))
                            Directory.CreateDirectory(dest.TrimEnd('\\') + @"\Projections");
                        
                        File.Copy(file, dest.TrimEnd('\\') + @"\Projections\" + Path.GetFileName(file), true);
                    }
                    if (Directory.Exists(src + @"\Web\Services"))
                    {
                        // Make sure that the destination directory exists
                        if (!Directory.Exists(dest.TrimEnd('\\') + @"\Services"))
                            Directory.CreateDirectory(dest.TrimEnd('\\') + @"\Services");

                        foreach (string file in Directory.GetFiles(src + @"\Web\Services", "*.asmx"))
                        {
                            File.Copy(file, dest.TrimEnd('\\') + @"\Services\" + Path.GetFileName(file), true);
                        }
                    }
                    if (Directory.Exists(src + @"\Web\Parts"))
                    {
                        // Make sure that the destination directory exists
                        if (!Directory.Exists(dest.TrimEnd('\\') + @"\Parts"))
                            Directory.CreateDirectory(dest.TrimEnd('\\') + @"\Parts");

                        foreach (string file in Directory.GetFiles(src + @"\Web\Parts", "*.ascx"))
                        {
                            File.Copy(file, dest.TrimEnd('\\') + @"\Parts\" + Path.GetFileName(file), true);
                        }
                    }
                    if (Directory.Exists(src + @"\Web\Scripts"))
                    {
                        // Make sure that the destination directory exists
                        if (!Directory.Exists(dest.TrimEnd('\\') + @"\Scripts"))
                            Directory.CreateDirectory(dest.TrimEnd('\\') + @"\Scripts");

                        foreach (string file in Directory.GetFiles(src + @"\Web\Scripts", "*.ascx"))
                        {
                            File.Copy(file, dest.TrimEnd('\\') + @"\Scripts\" + Path.GetFileName(file), true);
                        }
                    }

                    if (Directory.Exists(src + @"\Web\Xslt"))
                    {
                        // Make sure that the destination directory exists
                        if (!Directory.Exists(dest.TrimEnd('\\') + @"\Xslt"))
                            Directory.CreateDirectory(dest.TrimEnd('\\') + @"\Xslt");

                        foreach (string file in Directory.GetFiles(src + @"\Web\Xslt", "*.xslt"))
                        {
                            File.Copy(file, dest.TrimEnd('\\') + @"\Xslt\" + Path.GetFileName(file), true);
                        }
                    }
                    foreach (string file in Directory.GetFiles(src, "*.config"))
                    {
                        File.Copy(file, dest.TrimEnd('\\') + @"\" + Path.GetFileName(file), true);
                    }
                    
                    foreach (string file in Directory.GetFiles(src, "*.number"))
                    {
                        File.Copy(file, dest.TrimEnd('\\') + @"\" + Path.GetFileName(file), true);
                    }

                    // TODO: Check this.
                    // The Web project now contains a reference to each module, which takes care of importing the DLLs
                    /*
                    // Ensure that there's a bin directory for the module
                    if (!Directory.Exists(dest.TrimEnd('\\') + @"\bin\"))
                        Directory.CreateDirectory(dest.TrimEnd('\\') + @"\bin\");
                    // Copy the DLLs
                    foreach (string dll in Directory.GetFiles(src.TrimEnd('\\') + @"\bin\Debug\", "*.dll"))
                    {
                        if (dll.ToLower().Contains("module"))
                            File.Copy(dll, dest.TrimEnd('\\') + @"\bin\" + Path.GetFileName(dll), true);
                    }*/
                }
                catch (Exception ex)
                {
                    Console.Write("===== ERROR ===== Failed to install module from '" + src + "' to '" + dest + "'\n" +
                        ex.ToString());
                }
            }
        }
    }
}
