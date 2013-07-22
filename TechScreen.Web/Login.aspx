<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TechScreen.Web.Login" %>

<asp:Content runat="server" ID="HeadContent" ContentPlaceHolderID="FeaturedContent">
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div align="center">
        <section>
            <div class="content-wrapper">
                <hgroup class="title">
                    <h1 class="page-heading">Admin Login</h1>
                </hgroup>
            </div>
        </section>
        <section id="sectionLoginForm" class="login-form">

            <p class="validation-summary-errors" style="color: Red">
                <asp:Literal runat="server" ID="FailureText" />
            </p>
            <fieldset>
                <legend>
                    <h3>Log in Form
                    </h3>
                </legend>
                <p>
                </p>
                <div>
                    <p>
                        <asp:Label ID="Label1" runat="server" AssociatedControlID="UserName" CssClass="label">Username</asp:Label>
                    </p>
                    <p>
                        <asp:TextBox runat="server" ID="UserName" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="The user name field is required." />
                    </p>
                    <p>
                        <asp:Label ID="Label2" runat="server" AssociatedControlID="Password" CssClass="label">Password</asp:Label>
                    </p>
                    <p>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="The password field is required." />
                    </p>
                    <p>
                        <asp:CheckBox runat="server" ID="RememberMe" />
                        <asp:Label ID="Label3" runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Remember me?</asp:Label>
                    </p>
                    <p>
                        <asp:Button ID="Button1" runat="server" Text="Log In" OnClick="Button1_Click" CssClass="button" />
                    </p>
                </div>

            </fieldset>


        </section>
    </div>
</asp:Content>