<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true"
    CodeBehind="ManageRecruiter.aspx.cs" Inherits="TechScreen.Web.ManageRecruiter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <p>
        <h3>
            Manage Recruiter
        </h3>
    </p>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="tblData" width="100%">
        <thead>
            <tr>
                <th>
                    Name
                </th>
                <th>
                   Top Level ClientName
                </th>
                <th>
                  Email
                </th>
              
                <th>
                    PhonePrimary
                </th>
                <th style="width: 50px;">
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="4">
                    Proccessing
                </td>
            </tr>
        </tbody>
    </table>
    <div id='divdialog' style="display: none;">
        <input type="hidden" id='txtID' value='0' />
        <table>
            <tr>
                <td>
                    Top Level Client
                </td>
                <td>
                    <select id="TopLevelClientId" class="txtsmall">
                        <asp:Repeater runat="server" ID="rpttlclients">
                            <ItemTemplate>
                                <option value='<%#DataBinder.Eval(Container.DataItem,"Id")%>'><%# DataBinder.Eval(Container.DataItem,"Name")%></option>
                                </otpion>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    First Name
                </td>
                <td>
                    <input id='FirstName' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Last Name
                </td>
                <td>
                    <input id='LastName' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Email
                </td>
                <td>
                    <input id='Email' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Phone Primary
                </td>
                <td>
                    <input id='PhonePrimary' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Phone Secondary
                </td>
                <td>
                    <input id='PhoneSecondary' type="text" class="txtsmall" />
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
                "sAjaxSource": "ManageRecruiter.aspx?key=GetDataTable",
                "fnDrawCallback": function () {
                    var d = $("#btnAddNewRow").attr("id") + "";
                    if (d == "" || d == "null" || d == "undefined") {
                        var html = " &nbsp;<button type='button' class='add_row ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary ui-state-hover' id='btnAddNewRow' onclick='AddNew()'><span class='ui-button-icon-primary ui-icon ui-icon-plus'></span><span class='ui-button-text'>Add...</span></button>";
                        $('#tblData_length').append(html);
                    }
                }
            }).fnSetFilteringDelay(400);

            $("#divdialog").dialog({
                autoOpen: false,
                draggable: true,
                modal: true,
                resizable: true,
                width: 450,
                title: "Recruiter Detail",
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
            $("#trSendEmail").show();
        }
        function AddNew() {
            ClearForm();
            $("#divdialog").dialog("open");
        }
        function Save() {

            var user = {
                Id: $("#txtID").val(),
                FirstName: $("#FirstName").val(),
                LastName: $("#LastName").val(),
                TopLevelClientId: $("#TopLevelClientId").val(),
                TopLevelClientName: $("#TopLevelClientId option:selected").text().trim(),
                Email: $("#Email").val(),
                PhonePrimary: $("#PhonePrimary").val(),
                PhoneSecondary: $("#PhoneSecondary").val(),
               };
            var d = "Key=Save";
            d += "&record=" + JSON.stringify(user);
            $.ajax({
                url: "ManageRecruiter.aspx",
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
                    url: "ManageRecruiter.aspx",
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
                url: "ManageRecruiter.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#FirstName").val(j.FirstName);
                        $("#LastName").val(j.LastName);
                        $("#Email").val(j.Email)
                        $("#TopLevelClientId").val(j.TopLevelClientId)
                        $("#PhonePrimary").val(j.PhonePrimary);
                        $("#PhoneSecondary").val(j.PhoneSecondary);
                      
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
            if (status == "True") {
                status = "False";
                img = "images/status-offline.png";
                title = "Click to make it active";
            }
            else {
                status = "True";
                img = "images/status-online.png";
                title = "Click to make it inactive";
            }
            $(el).attr("status-id", status);
            $(el).attr("src", img);
            $(el).attr("title", title);
            var d = "key=ChangeStatus";
            d += "&id=" + id;
            d += "&status=" + status;
            $.ajax({
                url: "ManageRecruiter.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                }
            });
        }

    </script>
</asp:Content>
