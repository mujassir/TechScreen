
using System.Configuration;
using TechScreen.Entities;



namespace TechScreen.Repositories
{
    public static class Connection
    {
        private static TechScreenEntities _db;
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["TechScreenEntities"].ConnectionString;
        }
        public static TechScreenEntities GetContext()
        {
            return _db ?? (_db = new TechScreenEntities(GetConnectionString()));
        }

        public static TechScreenEntities GetNewContext()
        {
            return new TechScreenEntities(GetConnectionString());
        }

    }
}