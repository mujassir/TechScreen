<%@ Page Title="" Language="C#" MasterPageFile="~/BootstrapMaster.Master" AutoEventWireup="true"
    CodeBehind="ManageClients.aspx.cs" Inherits="TechScreen.Web.ManageClients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
  <a class="largBtn">
        <span>Manage Clients</span></a>
    <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="tblData" width="100%">
        <thead>
            <tr>
                <th>
                    Name
                </th>
                <th>
                    TopLevelClient Name
                </th>
                <th>
                    Email
                </th>
                <th>
                    State
                </th>
                <th>
                    City
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
                    TopLevel Client Name
                </td>
                <td>
                    <asp:DropDownList ID="ddltlclients" DataTextField="Name" ClientIDMode="Static" CssClass="txtsmall"
                        DataValueField="id" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Client Name
                </td>
                <td>
                    <input id='txtClient_Name' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Email
                </td>
                <td>
                    <input id='txtemail' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Stat
                </td>
                <td>
                    <input id='txtstat' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    City
                </td>
                <td>
                    <input id='txtcity' type="text" class="txtsmall number" />
                </td>
            </tr>
            <tr>
                <td>
                    Zip
                </td>
                <td>
                    <input id='txtzip' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Contact First Name
                </td>
                <td>
                    <input id='txtcontactfristname' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Contact Last Name
                </td>
                <td>
                    <input id='txtcontactlastname' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Phone Primary
                </td>
                <td>
                    <input id='txtphoneprimary' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Phone Secondary
                </td>
                <td>
                    <input id='txtphonesecondary' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>
                    Address 1
                </td>
                <td>
                    <input id='txtaddress' type="text" class="txtsmall"/>
                </td>
            </tr>
            <tr>
                <td>
                    Address 2
                </td>
                <td>
                    <input id='txtaddress2' type="text" class="txtsmall" />
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
                //bJQueryUI: true,
                "sDom": "<'row'<'span8'l><'span8'f>r>t<'row'<'span8'i><'span8'p>>",
                "sPaginationType": "bootstrap",
                "iDisplayLength": 25,
                //"sPaginationType": "full_numbers",
                "bProcessing": true,
                "bServerSide": true,
                "sAjaxSource": "ManageClients.aspx?key=GetDataTable",
                "fnDrawCallback": function () {
                    var d = $("#btnAddNewRow").attr("id") + "";
                    if (d == "" || d == "null" || d == "undefined") {
                        var html = "<button type='button' class='btn' id='btnAddNewRow' onclick='AddNew()'><span class='ui-button-icon-primary ui-icon ui-icon-plus'></span><span class='ui-button-text'>New</span></button>";
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
                height:500,
                title: "Client Detail",
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
                Name: $("#txtClient_Name").val(),
                TopLevelClientId: $("#ddltlclients").val(),
                TopLevelClientName: $("#ddltlclients option:selected").text().trim(),
                City: $("#txtcity").val(),
                State: $("#txtstat").val(),
                Zip: $("#txtzip").val(),
                Email: $("#txtemail").val(),
                ContactFirstName: $("#txtcontactfristname").val(),
                ContactLastName: $("#txtcontactlastname").val(),
                PhonePrimary: $("#txtphoneprimary").val(),
                PhoneSecondary: $("#txtphonesecondary").val(),
                Address1: $("#txtaddress").val(),
                Address2: $("#txtaddress2").val()
            };
            var d = "Key=Save";
            d += "&record=" + JSON.stringify(user);
            $.ajax({
                url: "ManageClients.aspx",
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
                    url: "ManageClients.aspx",
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
                url: "ManageClients.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#txtClient_Name").val(j.Name);
                        $("#ddltlclients").val(j.TopLevelClientId);
                        $("#txtemail").val(j.Email)
                        $("#txtstat").val(j.State);
                        $("#txtcity").val(j.City);
                        $("#txtzip").val(j.Zip);
                        $("#txtcontactfristname").val(j.ContactFirstName);
                        $("#txtcontactlastname").val(j.ContactLastName);
                        $("#txtphoneprimary").val(j.PhonePrimary);
                        $("#txtphonesecondary").val(j.PhoneSecondary);
                        $("#txtaddress").val(j.Address1);
                        $("#txtaddress2").val(j.Address2);
                        $("#trSendEmail").hide();

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
                url: "ManageClients.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                }
            });
        }

    </script>
</asp:Content>
