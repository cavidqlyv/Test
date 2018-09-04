using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp12
{
    class Program
    {
        static void Main(string[] args)
        {
            string key;
            while (true)
            {
                try
                {

                    Console.WriteLine("Enter key");
                    key = Console.ReadLine();
                    switch (key)
                    {
                        case "basic":
                            Console.Clear();
                            DocumentProgram documentProgram = new DocumentProgram();
                            documentProgram.OpenDocument();
                            documentProgram.EditDocument();
                            documentProgram.SaveDocument();
                            break;
                        case "pro":
                            Console.Clear();
                            DocumentProgram proDocumentProgram = new ProDocumentProgram();
                            proDocumentProgram.OpenDocument();
                            proDocumentProgram.EditDocument();
                            proDocumentProgram.SaveDocument();
                            break;
                        case "expert":
                            Console.Clear();
                            DocumentProgram expertDocument = new ExpertDocument();
                            expertDocument.OpenDocument();
                            expertDocument.EditDocument();
                            expertDocument.SaveDocument();
                            break;
                    }
                }
                catch (Exception e)
                {

                    Console.WriteLine(e.Message);
                }

            }
        }
        class DocumentProgram
        {
            public void OpenDocument()
            {
                Console.WriteLine("Document Opened");
            }
            public virtual void EditDocument()
            {
                Console.WriteLine("Can Edit in Pro and Expert versions");
            }
            public virtual void SaveDocument()
            {
                Console.WriteLine("Can Save in Pro and Expert versions");
            }
        }
        class ProDocumentProgram : DocumentProgram
        {
            public override sealed void EditDocument()
            {
                Console.WriteLine("Document Edited");
            }
            public override void SaveDocument()
            {
                Console.WriteLine("Document Saved in doc format, for pdf format buy Expert packet");
            }
        }
        class ExpertDocument : ProDocumentProgram
        {
            public override void SaveDocument()
            {
                Console.WriteLine("Document Saved in pdf format");
            }
        }
    }
}
