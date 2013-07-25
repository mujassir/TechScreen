<%@ Page Title="" Language="C#" MasterPageFile="~/BootstrapMaster.Master" AutoEventWireup="true" CodeBehind="ManageSkills.aspx.cs" Inherits="TechScreen.Web.ManageSkills" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
   <a class="largBtn">
        <span>Manage Skills</span></a>
    <table cellpadding="0" cellspacing="0" border="0" class="bordered-table zebra-striped" id="tblData" width="100%">
        <thead>
            <tr>
               
                <th>Name
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
                <td>Skill Name
                </td>
                <td>
                    <input type="text" id="txtname" class="txtsmall" />
                   
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
                "sAjaxSource": "ManageSkills.aspx?key=GetDataTable",
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
                title: "Skill Detail",
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
                    },
                    {
                        text: "Save&Close",
                        click: function () {
                            Save();
                            $(this).dialog("close");
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
                Name: $("#txtname").val(),
               
            };
            var d = "Key=Save";
            d += "&record=" + JSON.stringify(user);
            $.ajax({
                url: "ManageSkills.aspx",
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
                    url: "ManageSkills.aspx",
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
                url: "ManageSkills.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#txtname").val(j.Name);
                       

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
