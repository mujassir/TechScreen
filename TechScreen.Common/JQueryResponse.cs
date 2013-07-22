using System.Collections.Generic;

namespace TechScreen.Common
{
    public class JQueryResponse
    {
        public int sEcho { get; set; }
        public int iTotalRecords { get; set; }
        public int iTotalDisplayRecords { get; set; }
        public List<List<string>> aaData { get; set; }

        public JQueryResponse()
        {
            aaData = new List<List<string>>();
        }
    }
}