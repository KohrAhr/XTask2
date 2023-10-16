using System;
using System.IO;
using ConsoleAppJsonAndXml.Functions;
using ConsoleAppJsonAndXml.Types;

namespace ConsoleAppJsonAndXml
{
    internal class Program
    {
        /// <summary>
        /// </summary>
        /// <param name="args"></param>
        /// <returns></returns>
        static int Main(string[] args)
        {
            string sourceFile = "AppData\\Input.json";
            string targetFile = "AppData\\Output.xml";

            if (String.IsNullOrEmpty(sourceFile) || String.IsNullOrEmpty(targetFile))
            {
                Console.WriteLine("Please indicate source file with Json data and target file name");

                return 2;
            }

            string sourceData = String.Empty;
            try
            {
                sourceData = File.ReadAllText(sourceFile);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.Write(ex.ToString());
            }

            if (String.IsNullOrEmpty(sourceData))
            {
                Console.WriteLine("Content of source file is empty");

                return 3;
            }

            // Load data from file to Class
            RootEntry rootEntry = DataHelper.JsonStringToClass<RootEntry>(sourceData);

            // Save Class as XML file -- Way 1
            DataHelper.ClassToXmmlFile(rootEntry, "ResultWay1.xml");

            // Save Class as XML file -- Way 2 -- as in requirement
            rootEntry.SaveXmlToFile("ResultWay2.xml");

            return 0;
        }
    }
}
