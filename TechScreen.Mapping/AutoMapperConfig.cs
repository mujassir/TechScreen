using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using TechScreen.Entities;

namespace TechScreen.Mapping
{
    public static class AutoMapperConfig
    {
        public static void InitializeMappings()
        {
            AutoMapper.Mapper.CreateMap<Candidate, Candidate>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Client, Client>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Position, Position>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Question, Question>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Recruiter, Recruiter>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Role, Role>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Screener, Screener>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Screening, Screening>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<ScreeningQA, ScreeningQA>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<Skill, Skill>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<TopLevelClient, TopLevelClient>().IgnoreAllNonExisting();
            AutoMapper.Mapper.CreateMap<User, User>().IgnoreAllNonExisting();
        }

        public static IMappingExpression<TSource, TDestination> IgnoreAllNonExisting<TSource, TDestination>
            (this IMappingExpression<TSource, TDestination> expression)
        {
            var flags = BindingFlags.Public | BindingFlags.Instance;
            var sourceType = typeof(TSource);
            var destinationProperties = typeof(TDestination).GetProperties(flags);
            string[] ignorProperties = { "Id", "EntityKey", "EntityState" };
            foreach (var property in destinationProperties)
            {
                if (sourceType.GetProperty(property.Name, flags) == null
                    || ignorProperties.Contains(property.Name)
                    || property.PropertyType.Name == "EntityCollection`1"
                    || property.PropertyType.Name == "EntityReference`1"
                    || property.PropertyType.BaseType.Name == "EntityObject")
                {
                    expression.ForMember(property.Name, opt => opt.Ignore());
                }
            }
            return expression;
        }
    }


}
