<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true" CodeBehind="ManageQuestions.aspx.cs" Inherits="TechScreen.Web.ManageQuestions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <p>
        <h3>
            Manage Questions
        </h3>
    </p>
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="tblData" width="100%">
        <thead>
            <tr>
                <th>
                  Skill  Name
                </th>
                <th>
                   Skill Level
                </th>
                <th>
                   Question
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
                    Skill Name
                </td>
                <td>
                    <asp:DropDownList ID="ddlskill" DataTextField="Name" ClientIDMode="Static" CssClass="txtsmall"
                        DataValueField="id" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Skill level
                </td>
                <td>
                    <asp:DropDownList ID="ddlskilllevel" DataTextField="Name" ClientIDMode="Static" CssClass="txtsmall"
                        DataValueField="id" runat="server">
                        <asp:ListItem Value="1">Skill Level 1</asp:ListItem>
                         <asp:ListItem Value="2">Skill Level 2</asp:ListItem>
                          <asp:ListItem Value="3">Skill Level 3</asp:ListItem>
                           <asp:ListItem Value="4">Skill Level 4</asp:ListItem>
                            <asp:ListItem Value="5">Skill Level 5</asp:ListItem>

                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                   Question Text
                </td>
                <td>
                   
                    <textarea id='txtquestion' cols="1" rows="4">
                    </textarea>
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
                "sAjaxSource": "ManageQuestions.aspx?key=GetDataTable",
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
                width: 600,
                title: "Question Detail",
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
                SkillId: $("#ddlskill").val(),
                SkillName: $("#ddlskill option:selected").text().trim(),
                QuestionText: $("#txtquestion").val(),
                Skilllevel: $("#ddlskilllevel").val(),
                SkillLevelName: $("#ddlskilllevel option:selected").text().trim(),
               
            };
            var d = "Key=Save";
            d += "&record=" + JSON.stringify(user);
            $.ajax({
                url: "ManageQuestions.aspx",
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
                    url: "ManageQuestions.aspx",
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
                url: "ManageQuestions.aspx",
                type: "POST",
                data: d,
                success: function (response) {
                    var j = $.parseJSON(response);
                    if (j != null) {
                        ClearForm();
                        $("#txtID").val(j.Id);
                        $("#ddlskill").val(j.SkillId);
                        $("#ddlskilllevel").val(j.Skilllevel);
                        $("#txtquestion").val(j.QuestionText)
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
