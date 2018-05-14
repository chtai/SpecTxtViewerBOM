using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Text;

namespace ConvertWithoutBOMToUTF8
{
    static class Program
    {
        /// <summary>
        /// 應用程式的主要進入點。
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new Form1());

            if (args.Length == 0) return;

            string targetDir = args[0]; //@"C:\60_LN_02_20180510112049\60_LN_02_20180510112049\MP2\import";
            string[] files = Directory.GetFiles(targetDir);
            foreach(string filename in files)
            {
                string file_name_ext = Path.GetExtension(filename);
                if(file_name_ext.ToLower() == ".txt" || file_name_ext.ToLower() == ".sql")
                {
                    var fileslines = File.ReadAllLines(filename);
                    File.Delete(filename);
                    File.WriteAllLines(filename, fileslines, new UTF8Encoding(true));
                }
            }
        }
    }
}
