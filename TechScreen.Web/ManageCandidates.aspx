<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true" CodeBehind="ManageCandidates.aspx.cs" Inherits="TechScreen.Web.ManageCandidates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <p>
        <h3>Manage Candidates
        </h3>
    </p>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="tblData" width="100%">
        <thead>
            <tr>
                <th>Frist Name
                </th>
                <th>Last Name
                </th>
                <th>Email
                </th>
                <th>Phone
                </th>
                <th>City
                </th>
                <th>State
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
                <td>First Name
                </td>
                <td>
                    <input id='txtFirstName' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Last Name
                </td>
                <td>
                    <input id='txtLastName' type="text" class="txtsmall" />
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
                <td>Phone Primary
                </td>
                <td>
                    <input id='txtPhonePrimary' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Phone Secondary
                </td>
                <td>
                    <input id='txtPhoneSecondary' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>City
                </td>
                <td>
                    <input id='txtCity' type="text" class="txtsmall number" />
                </td>
            </tr>
            <tr>
                <td>Stat
                </td>
                <td>
                    <input id='txtStat' type="text" class="txtsmall" />
                </td>
            </tr>

            <tr>
                <td>Zip
                </td>
                <td>
                    <input id='txtZip' type="text" class="txtsmall" />
                </td>
            </tr>


            <tr>
                <td>Address 1
                </td>
                <td>
                    <input id='txtAddress1' type="text" class="txtsmall" />
                </td>
            </tr>
            <tr>
                <td>Address 2
                </td>
                <td>
                    <input id='txtAddress2' type="text" class="txtsmall" />
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
                "sAjaxSource": "ManageCandidates.aspx?key=GetDataTable",
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
                title: "Candidate Detail",
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
        }
        function AddNew() {
            ClearForm();
            $("#divdialog").dialog("open");
        }
        function Save() {

            var user = {
                Id: $("#txtID").val(),
                FirstName: $("#txtFirstName").val(),
                LastName: $("#txtLastName").val(),
                City: $("#txtCity").val(),
                State: $("#txtStat").val(),
                Zip: $("#txtZip").val(),
                Email: $("#txtEmail").val(),
                PhonePrimary: $("#txtPhonePrimary").val(),
                PhoneSecondary: $("#txtPhoneSecondary").val(),
                Address1: $("#txtAddress1").val(),
                Address2: $("#txtAddress2").val()
            };
            var d = "Key=Save";
            d += "&record=" + JSON.stringify(user);
            $.ajax({
                url: "ManageCandidates.aspx",
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
                    url: "ManageCandidates.aspx",
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
                url: "ManageCandidates.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#txtFirstName").val(j.FirstName);
                        $("#txtLastName").val(j.LastName);
                        $("#txtEmail").val(j.Email)
                        $("#txtStat").val(j.State);
                        $("#txtCity").val(j.City);
                        $("#txtZip").val(j.Zip);
                        $("#txtPhonePrimary").val(j.PhonePrimary);
                        $("#txtPhoneSecondary").val(j.PhoneSecondary);
                        $("#txtAddress1").val(j.Address1);
                        $("#txtAddress2").val(j.Address2);
                    }
                }
            });
            $("#divdialog").dialog("open");
        }

    </script>
</asp:Content>
