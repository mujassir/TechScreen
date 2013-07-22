using System;
using System.Collections.Generic;
using System.Linq;
using TechScreen.Entities;
using System.Linq.Expressions;
using System.Data.Objects;

using System.Web;


namespace TechScreen.Repositories
{
    public class GenericRepository<T>
        where T : class
    {
        protected TechScreenEntities Db = null;
        public GenericRepository()
        {
            Db = Connection.GetContext();
            //db.SaveChanges();
        }
        private ObjectSet<T> _objectset;
        protected ObjectSet<T> ObjectSet
        {
            get { return _objectset ?? (_objectset = Db.CreateObjectSet<T>()); }
        }

        public virtual void Add(T entity)
        {
            ObjectSet.AddObject(entity);
            SaveChanges();
        }

        public virtual void Add(List<T> entities)
        {
            foreach (var entity in entities)
            {
                ObjectSet.AddObject(entity);
            }
            SaveChanges();
        }
        public virtual void Save(T entity)
        {
            if (((dynamic)entity).Id == 0)
            {
                Add(entity);
            }
            else
            {
                Update(entity);
            }
        }
        public virtual void Update(T entity)
        {
            int id = ((dynamic)entity).Id;
            var dbObject = ObjectSet.Where("it.Id=" + id).FirstOrDefault();
            AutoMapper.Mapper.Map(entity, dbObject);
            SaveChanges();
        }
        public virtual T GetById(int id)
        {
            return ObjectSet.Where("it.Id=" + id).FirstOrDefault();
        }
        public virtual void Delete(T entity)
        {
            if (entity == null) return;
            ObjectSet.DeleteObject(entity);
            SaveChanges();
        }
        public virtual void Delete(int id)
        {
            var v = ObjectSet.Where("it.Id=" + id).FirstOrDefault();
            if (v == null) return;
            ObjectSet.DeleteObject(v);
            SaveChanges();
        }
        public virtual T FirstOrDefault()
        {
            return ObjectSet.FirstOrDefault();
        }
        public virtual T FirstOrDefault(Expression<Func<T, bool>> predicate)
        {
            return ObjectSet.FirstOrDefault(predicate);
        }
        public virtual List<T> GetAll(Expression<Func<T, bool>> predicate)
        {
            return ObjectSet.ToList();
        }
        public virtual List<T> GetAll()
        {
            return ObjectSet.ToList();
        }

        public virtual IQueryable<T> AsQueryable()
        {
            return ObjectSet.AsQueryable();
        }
        public virtual IQueryable<T> AsQueryable(Expression<Func<T, bool>> predicate)
        {
            return ObjectSet.AsQueryable();
        }
        protected virtual void SaveChanges()
        {
            Db.SaveChanges();
        }
    }
}