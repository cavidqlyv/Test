<%@ Control Language="C#" ClassName="AnalyticsFooter" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
        <%= Config.Application.Settings.GetString("AnalyticsCode") %>