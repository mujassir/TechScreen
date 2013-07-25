<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true"
    CodeBehind="ManageUsers.aspx.cs" Inherits="TechScreen.Web.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <p>
        <h3>Manage Users
        </h3>
    </p>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="tblData" width="100%">
        <thead>
            <tr>
                <th style='width: 20px;'></th>
                <th>User
                </th>
                <th>Role
                </th>
                <th>Email
                </th>
                <th style="width: 50px;"></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="4">Proccessing
                </td>
            </tr>
        </tbody>
    </table>
    <div id='divdialog' style="display: none;">
        <input type="hidden" id='txtID' value='0' />
        <table>
            <tr>
                <td colspan='2' style='text-align: center;'>
                    <span class='error-label' id='lblError'></span>
                </td>
            </tr>
            <tr>
                <td>Username
                </td>
                <td>
                    <input id='txtUserName' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Email
                </td>
                <td>
                    <input id='txtEmail' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Password
                </td>
                <td>
                    <input id='txtPassword' type="password" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Role
                </td>
                <td>
                    <select id='txtRole' class="txtsmall">
                        <asp:Repeater ID="rptRoles" runat="server">
                            <ItemTemplate>
                                <option
                                    value='<%#DataBinder.Eval(Container.DataItem , "Id") %>'><%#DataBinder.Eval(Container.DataItem , "Name") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        function HideMessage() {

        }
        function ShowMessage() {

        }
        function ShowMessageJson() {

        }


        $(document).ready(function () {
            oTable = $('#tblData').dataTable({
                bJQueryUI: true,
                "sPaginationType": "full_numbers",
                "bProcessing": true,
                "bServerSide": true,
                "sAjaxSource": "ManageUsers.aspx?key=GetDataTable",
                "fnDrawCallback": function () {
                    var d = $("#btnAddNewRow").attr("id") + "";
                    if (d == "" || d == "null" || d == "undefined") {
                        var html = "<button type='button' class='add_row ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-state-hover' id='btnAddNewRow' onclick='AddNew()'><span class='ui-button-icon-primary ui-icon ui-icon-plus'></span><span class='ui-button-text'>Add...</span></button>";
                        $('#tblData_length').append(html);
                    }
                }
            }).fnSetFilteringDelay(600);

            $("#divdialog").dialog({
                autoOpen: false,
                draggable: true,
                modal: true,
                resizable: true,
                start: "slide",
                title: "User Detail",
                buttons: [
                    {
                        text: "Close",
                        click: function () { $(this).dialog("close"); }
                    },
                    {
                        text: "Save",
                        click: function () {
                            Save();
                            // $(this).dialog("close");
                        }
                    }
                ]
            });
        });

        function ClearForm() {
            HideMessage();
            $("#txtID").val("0");
            $("input[type='text'], select").val("");
            $("input[type='checkbox'], input[type='radio']").attr("checked", false);
            $("#txtPassword").val("");
            //$("#txtRole").val("3");
            $("#lblError").html("");
        }
        function AddNew() {
            ClearForm();
            $("#divdialog").dialog("open");
        }
        function Save() {
            var user = {
                Id: $("#txtID").val(),
                UserName: $("#txtUserName").val(),
                Email: $("#txtEmail").val(),
                Password: $("#txtPassword").val(),
                RoleId: $("#txtRole").val(),
                RoleName: $("#txtRole option:selected").text().trim()
            };
            var d = "Key=Save";
            d += "&user=" + JSON.stringify(user);
            $.ajax({
                url: "ManageUsers.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);

                    if (!j.Success) {
                        if (j.Data == "1")
                            $("#lblError").html("User already exist");
                        else
                            ShowMessageJson(response);
                    }
                    else {
                        ShowMessageJson(response);
                        $("#divdialog").dialog("close");
                        oTable.fnDraw();
                    }
                }
            });
        }
        function Delete(id) {
            HideMessage();
            if (confirm("Are you sure you want to delete ?")) {
                var d = "key=Delete";
                d += "&id=" + id;
                $.ajax({
                    url: "ManageUsers.aspx",
                    type: "POST",
                    data: d,
                    success: function (response) {
                        ShowMessageJson(response);
                        oTable.fnDraw();
                    }
                });
            }
        }
        function Edit(id) {
            var d = "key=GetByID";
            d += "&id=" + id;
            $.ajax({
                url: "ManageUsers.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#txtUserName").val(j.UserName);
                        $("#txtEmail").val(j.Email);
                        $("#txtPassword").val(j.Password);
                        $("#txtRole").val(j.RoleId);
                    }
                }
            });
            $("#divdialog").dialog("open");
        }
        function ChangeStatus(el) {
            var id = $(el).attr("data-id");
            var status = $(el).attr("status-id");
            var img = "";
            var title = "";
            if (status == "0") {
                status = "1";
                img = "content/images/status-offline.png";
                title = "Click to make it active";
            }
            else {
                status = "0";
                img = "content/images/status-online.png";
                title = "Click to make it inactive";
            }
            $(el).attr("status-id", status);
            $(el).attr("src", img);
            $(el).attr("title", title);
            var d = "key=ChangeStatus";
            d += "&id=" + id;
            d += "&status=" + status;
            $.ajax({
                url: "ManageUsers.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                }
            });
        }
    </script>
</asp:Content>
