using System.Configuration;

namespace TechScreen.Common
{
    public static class ConfigHelper
    {
        public static string AppSetting(string key)
        {
            return ConfigurationManager.AppSettings[key] + "";
        }

    }
}