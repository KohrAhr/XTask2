using ConsoleAppJsonAndXml.Functions;
using System;

namespace ConsoleAppJsonAndXml.Types
{
    [Serializable]
    // as in requirement. in lower case.
    public class RootEntry
    {
        public SubEntry subEntry { get; set; }

        public virtual void SaveXmlToFile(string aFilename)
        {
            DataHelper.ClassToXmmlFile(this, aFilename);
        }
    }
}
