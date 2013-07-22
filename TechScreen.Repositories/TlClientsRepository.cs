using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechScreen.Entities;

namespace TechScreen.Repositories
{
    public class TlClientRepository : GenericRepository<TopLevelClient>
    {
        //public IEnumerable<string> GetAllNames()
        //{
        //    return ObjectSet.Select(p => p.Name).ToList();
        //}
        //public bool IsExist(int id, string email)
        //{
        //    return ObjectSet.Any(p => p.Email == email && p.Id != id);
        //}

        //public TopLevelClient Get(string email, string password)
        //{
        //    return ObjectSet.FirstOrDefault(p => p.Email == email && p.Name == password);
        //}
        //public TopLevelClient Get(int id)
        //{
        //    return ObjectSet.FirstOrDefault(p => p.Id == id);
        //}
    }
}
