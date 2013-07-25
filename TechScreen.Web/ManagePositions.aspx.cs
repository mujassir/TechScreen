using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TechScreen.Web.Code;
using TechScreen.Repositories;
using TechScreen.Common;
using Newtonsoft.Json;
using TechScreen.Entities;
using System.Text;

namespace TechScreen.Web
{
    public partial class ManagePositions : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var key = Request["key"] + "";
            if (key != "")
            {
                string data = null;
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
            if (!Page.IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            var skills = new SkillRepository().GetAll();
            var recruiters = new RecruiterRepository().GetNames();
            rptRecruiters.DataSource = recruiters;
            rptSkills.DataSource = skills;
            rptSkills.DataBind();
            //rptRequiredSkills.DataBind();
            rptRecruiters.DataBind();

        }


        private string Delete()
        {
            string result;
            var id = Numerics.GetInt(Request["Id"]);
            try
            {
                var repo = new PositionRepository();
                repo.Delete(id);
                result = JsonResult(true, "Record deleted successuflly");

            }
            catch (Exception ex)
            {
                result = JsonResult(false, ex.Message);
            }
            return result;
        }
        public string Save()
        {
            string result;
            try
            {
                var repo = new PositionRepository();
                var userInput = JsonConvert.DeserializeObject<Position>(Request["user"]);
                repo.Save(userInput);
                result = JsonResult(true, "Record saved successfully");
            }
            catch (Exception ex)
            {
                result = JsonResult(false, ex.Message);
            }
            return result;
        }
        public string GetById()
        {
            string result;
            var id = Numerics.GetInt(Request["Id"]);
            try
            {
                result = JsonConvert.SerializeObject(new PositionRepository().GetById(id));
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }

        public string GetDataTable()
        {
            var coloumns = new[] { "", "Name", "ReqNumber", "RecruiterName", "PrimarySkillName", "PrimarySkillLevel", "" };
            var echo = Int32.Parse(Request.Params["sEcho"]);
            var displayLength = Int32.Parse(Request.Params["IdisplayLength"]);
            var colIndex = Int32.Parse(Request.Params["iSortCol_0"]);
            var displayStart = Int32.Parse(Request.Params["IdisplayStart"]);
            var search = (Request.Params["sSearch"] + "").Trim();

            var dal = new PositionRepository();
            var records = dal.AsQueryable();

            var totalRecords = records.Count();
            var totalDisplayRecords = totalRecords;
            var filteredList = records;
            if (search != "")
                filteredList = records.Where(p =>
                                             p.Name.Contains(search)
                                             || p.ReqNumber.Contains(search)
                                             || p.PrimarySkillName.Contains(search)
                                             || p.RecruiterName.Contains(search)
                    );
            var orderedList = filteredList.OrderByDescending(p => p.Id);
            if (colIndex < coloumns.Length && coloumns[colIndex] + "" != "")
            {
                string sortDir = Request.Params["sSortDir_0"];
                orderedList = sortDir == "asc" ? filteredList.OrderBy(coloumns[colIndex]) : filteredList.OrderByDescending(coloumns[colIndex]);
            }
            var sb = new StringBuilder();
            sb.Clear();
            var rs = new JQueryResponse();
            foreach (var item in orderedList.Skip(displayStart).Take(displayLength))
            {
                var data = new List<string>();
                const string method = "onclick='ChangeStatus(this)'";

                var status = "<img class='icon' src='content/images/status-online.png' title='Click to make it inactive' " + method + " data-Id='" + item.Id + "' status-Id='" + item.RecordStatus + "' />";
                if (item.RecordStatus == (byte)RecordStatus.Inactive)
                    status = "<img class='icon' src='content/images/status-offline.png' title='Click to make it active' " + method + " data-Id='" + item.Id + "' status-Id='" + item.RecordStatus + "' />";
                data.Add(status);
                data.Add(item.Name);
                data.Add(item.ReqNumber);
                data.Add(item.RecruiterName);
                data.Add(item.PrimarySkillName);
                //data.Add(item.PrimarySkillLevel + "");
                var editIcon = "<img  src='content/images/edit.png' class='icon'  alt='' onclick=\"Edit(" + item.Id + ")\"  style='float:left'  title='Edit Record' />";
                var deleteIcon = "<img Id='delete'  src='content/images/delete.png'  class='icon' alt='' onclick=\"Delete(" + item.Id + ")\" style='float:right'  title='Delete Record' />";
                var icons = "";
                icons += editIcon;
                icons += deleteIcon;
                data.Add(icons);
                rs.aaData.Add(data);
            }
            rs.sEcho = echo;
            rs.iTotalRecords = totalRecords;
            rs.iTotalDisplayRecords = totalDisplayRecords;

            return JsonConvert.SerializeObject(rs);
        }

        public string ChangeStatus()
        {
            string result;
            try
            {
                int id;
                int.TryParse(Request["Id"], out id);
                byte status;
                byte.TryParse(Request["status"], out status);
                var repo = new PositionRepository();

                repo.ChangeStatus(id, status);
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