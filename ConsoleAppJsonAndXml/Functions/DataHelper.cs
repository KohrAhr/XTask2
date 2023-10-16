using System;
using System.IO;
using System.Xml.Serialization;
using Newtonsoft.Json;

namespace ConsoleAppJsonAndXml.Functions
{
    public static class DataHelper
    {
        /// <summary>
        ///     String to Class
        /// </summary>
        /// <typeparam name="T">Type of class</typeparam>
        /// <param name="aValue">Source data in JSON</param>
        /// <returns>Instance of Class with data</returns>
        public static T JsonStringToClass<T>(string aValue)
        {
            try
            { 
                // Load data from file to Class
                T rootEntry = JsonConvert.DeserializeObject<T>(aValue);

                return rootEntry;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.Write(ex.ToString());
                return default;
            }
        }

        /// <summary>
        ///     Covert String to XML
        /// </summary>
        /// <typeparam name="T">Type of class</typeparam>
        /// <param name="aClass">Data</param>
        /// <returns>XML as string</returns>
        public static void ClassToXmmlFile<T>(T aClass, string aFilename)
        {
            try
            { 
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));

                // Empty namespace, as in Sample
                XmlSerializerNamespaces namespaces = new XmlSerializerNamespaces();
                namespaces.Add(string.Empty, string.Empty);

                using (StreamWriter streamWriter = new StreamWriter(aFilename))
                {
                    xmlSerializer.Serialize(streamWriter, aClass, namespaces);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.Write(ex.ToString());
            }
        }
    }
}
