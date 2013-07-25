using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechScreen.Repositories;
using TechScreen.Entities;

namespace TechScreen.Repositories
{
    public class RecruiterRepository : GenericRepository<Recruiter>
    {
        public Dictionary<int, string> GetNames()
        {
            return ObjectSet.ToDictionary(p => p.Id, p => p.FirstName);
        }
    }
}
