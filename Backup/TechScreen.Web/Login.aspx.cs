using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TechScreen.Repositories;
using TechScreen.Common;
using System.Web.Security;

namespace TechScreen.Web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            var rs = new UserRepository();
            var user = rs.Get(UserName.Text, Password.Text);
            if (user != null)
            {
                if (user.RecordStatus == (byte)RecordStatus.Active)
                {
                    Session["User"] = user;
                    FormsAuthentication.RedirectFromLoginPage(user.UserName, RememberMe.Checked);
                    var returnUrl = Request["ReturnUrl"] + "";
                    returnUrl = returnUrl == "" ? "ManageTlClients.aspx" : returnUrl;
                    Response.Redirect(returnUrl);
                }
                else
                {
                    FailureText.Text = "User is not activated yet";
                }
            }
            else
            {

                FailureText.Text = "Username or password is incorrect";
            }
        }
    }
}