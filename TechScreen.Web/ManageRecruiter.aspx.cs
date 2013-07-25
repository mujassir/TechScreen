using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TechScreen.Web.Code;
using TechScreen.Repositories;
using TechScreen.Entities;
using Newtonsoft.Json;
using System.Text;
using TechScreen.Common;
using System.Web.Script.Serialization;

namespace TechScreen.Web
{
    public partial class ManageRecruiter : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var key = Request["key"] + "";

            string data = null;

            if (key == "")
            {
                var dal = new TlClientRepository();
                var records = dal.GetAll();
                rpttlclients.DataSource = records;
                rpttlclients.DataBind();
                return;
            }

            switch (key)
            {
                case "GetDataTable":
                    data = GetDataTable();
                    break;
                case "Delete":
                    data = Delete();
                    break;
                case "ChangeStatus":
                    data = ChangeStatus();
                    break;
                case "GetByID":
                    data = GetById();
                    break;
                case "Save":
                    data = Save();
                    break;
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            if (data != null) Response.Write(data);
            Response.Flush();
            Response.End();
        }

        private string Delete()
        {
            string result;
            var id = int.Parse(Request["id"]);
            try
            {
                var repo = new RecruiterRepository();
                repo.Delete(id);
                result = JsonResult(true, "Record deleted successfully");

            }
            catch (Exception ex)
            {
                result = JsonResult(false, ex.Message);
            }
            return result;
        }

        private string Save()
        {
            string result;
            try
            {
                var repo = new RecruiterRepository();
                var record = JsonConvert.DeserializeObject<Recruiter>(Request["record"]);
                // record.ClientId = ClientID;
                repo.Save(record);
                //if (record.ID  == 0)
                //{
                //    repo.Add(record);
                //}
                //else
                //{
                //    repo.Update(record);
                //}
                result = JsonResult(true, "Record saved successfully");
            }
            catch (Exception ex)
            {
                result = JsonResult(false, ex.Message);
            }
            return result;
        }

        private string GetById()
        {
            string result = "";
            var id = int.Parse(Request["id"]);
            try
            {
                result = JsonConvert.SerializeObject(new RecruiterRepository().GetById(id));
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }

        private string GetDataTable()
        {
            var coloumns = new[] { "FirstName", "LastName", "", "State", "City", "PhonePrimary", "" };
            var echo = Int32.Parse(Request.Params["sEcho"]);
            var displayLength = Int32.Parse(Request.Params["iDisplayLength"]);
            var colIndex = Int32.Parse(Request.Params["iSortCol_0"]);
            var displayStart = Int32.Parse(Request.Params["iDisplayStart"]);
            var search = (Request.Params["sSearch"] + "").Trim();

            var dal = new RecruiterRepository();
            var records = dal.AsQueryable();

            var totalRecords = records.Count();
            var totalDisplayRecords = totalRecords;
            var filteredList = records;
            if (search != "")
                filteredList = records.Where(p =>
                                             p.Email.Contains(search)
                                             || p.FirstName.Contains(search)
                                              || p.LastName.Contains(search)
                                             || p.TopLevelClientName.Contains(search)

                                             || p.PhonePrimary.Contains(search)
                    );
            var orderedList = filteredList.OrderByDescending(p => p.Id);
            if (colIndex < coloumns.Length && coloumns[colIndex] + "" != "")
            {
                var sortDir = Request.Params["sSortDir_0"];
                orderedList = sortDir == "asc" ? filteredList.OrderBy(coloumns[colIndex]) : filteredList.OrderByDescending(coloumns[colIndex]);
            }
            var sb = new StringBuilder();
            sb.Clear();
            var rs = new JQueryResponse();
            foreach (var item in orderedList.Skip(displayStart).Take(displayLength))
            {
                var data = new List<string>();
                const string method = "onclick='ChangeStatus(this)'";
                //var status = "<img class='icon' src='images/status-offline.png' title='Click to make it active' " + method + " data-id='" + item.Id + "' status-id='" + item.Active + "' />";

                //if (item.Active.HasValue && item.Active.Value)
                //    status = "<img class='icon' src='images/status-online.png' title='Click to make it inactive' " + method + " data-id='" + item.Id + "' status-id='" + item.Active + "' />";
                //data.Add(status);
                data.Add(item.FirstName + " " + item.LastName);
                data.Add(item.TopLevelClientName);
                data.Add(item.Email);
                data.Add(item.PhonePrimary);
                var editIcon = "<img  src='Content/images/edit.png' class='icon'  alt='' onclick=\"Edit(" + item.Id + ")\"  style='float:left'  title='Edit Record' />";
                var deleteIcon = "<img id='delete'  src='Content/images/delete.png'  class='icon' alt='' onclick=\"Delete(" + item.Id + ")\" style='float:right'  title='Delete Record' />";
                var icons = "";
                icons += editIcon;
                icons += deleteIcon;
                data.Add(icons);
                rs.aaData.Add(data);
            }
            rs.sEcho = echo;
            rs.iTotalRecords = totalRecords;
            rs.iTotalDisplayRecords = totalDisplayRecords;
            return new JavaScriptSerializer().Serialize(rs);
        }

        private string ChangeStatus()
        {
            string result;
            try
            {
                int id;
                int.TryParse(Request["id"], out id);
                var repo = new RecruiterRepository();
                var v = repo.GetById(id);
                if (v != null)
                {
                    // v.Active = Convert.ToBoolean(Request["status"]);
                    // repo.SaveChanges();
                }
                result = JsonResult(true, "Status changed successfully");
            }
            catch (Exception ex)
            {
                result = JsonResult(false, ex.Message);
            }

            return result;
        }
    }
}