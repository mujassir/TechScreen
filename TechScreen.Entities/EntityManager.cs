using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace TechScreen.Entities
{
   public static class EntityManager

    {
       public static Type[] GetTypesInNamespace()
       {
           string nameSpace = "TechScreen.Entities";
           Assembly assembly = Assembly.GetExecutingAssembly();
           return assembly.GetTypes().Where(t => String.Equals(t.Namespace, nameSpace, StringComparison.Ordinal)).ToArray();
       }
    }
}
