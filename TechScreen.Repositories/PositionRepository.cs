using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechScreen.Repositories;
using TechScreen.Entities;

namespace TechScreen.Repositories
{
    public class PositionRepository : GenericRepository<Position>
    {
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
