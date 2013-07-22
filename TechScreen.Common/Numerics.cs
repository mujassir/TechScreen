using System;
using System.Globalization;

namespace TechScreen.Common
{
    public static class Numerics
    {
        public static int GetInt(object input)
        {
            if (input == null || input + "" == "") return 0;
            try
            {
                return Convert.ToInt32(input);
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public static string DecimalToString(decimal value)
        {
            return decimal.Round(value, 2).ToString(CultureInfo.InvariantCulture);
            //return value.ToString("##.##");
        }

        public static decimal GetDecimal(object input)
        {
            if (input == null || input + "" == "") return 0;
            try
            {
                return Convert.ToDecimal(input);
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public static double GetDouble(object input)
        {
            if (input == null || input + "" == "") return 0;
            try
            {
                return Convert.ToDouble(input);
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}