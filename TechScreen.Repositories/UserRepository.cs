using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechScreen.Entities;

namespace TechScreen.Repositories
{
    public class UserRepository : GenericRepository<User>
    {
        public bool IsExist(int id, string userName)
        {
            return ObjectSet.Any(p => p.UserName == userName && p.Id != id);
        }

        public User Get(string userName, string password)
        {
            return ObjectSet.FirstOrDefault(p => p.UserName == userName && p.Password == password);
        }

        public void Update(User u)
        {
            var v = ObjectSet.FirstOrDefault(p => p.Id == u.Id);
            if (v != null)
            {
                v.Email = u.Email;
                v.Password = u.Password;
                v.UserName = u.UserName;
                v.RoleId = u.RoleId;
                v.RoleName = u.RoleName;
            }
            SaveChanges();
        }
        public void ChangeStatus(int id, byte status)
        {
            var v = ObjectSet.FirstOrDefault(p => p.Id == id);
            if (v != null)
            {
                v.RecordStatus = status;
                SaveChanges();
            }
        
        }
    }
}
