using System;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.State
{
	/// <summary>
	/// Stores the state of the current user's issue filter preferences.
	/// </summary>
	static public class IssueFilterState
	{
		static private StateNameValueCollection<bool> filterFlags;
		static public StateNameValueCollection<bool> FilterFlags
		{
			get {
				if (filterFlags == null)
					filterFlags = new StateNameValueCollection<bool>(StateScope.Session, "Issues.IssueFilterFlags");
				
				return filterFlags;
			}
			set { filterFlags = value; }
		}
		
		static public bool ShowPending
		{
			get {
				if (FilterFlags == null || FilterFlags.Keys == null || !FilterFlags.Keys.Contains("ShowPending"))
					return true;
				return FilterFlags["ShowPending"]; }
			set { FilterFlags["ShowPending"] = value; }
		}
		
		static public bool ShowResolved
		{
			get {
				if (FilterFlags == null || FilterFlags.Keys == null || !FilterFlags.Keys.Contains("ShowResolved"))
					return false;
				return FilterFlags["ShowResolved"]; }
			set { FilterFlags["ShowResolved"] = value; }
		}
		
		static public bool ShowClosed
		{
			get {
				if (FilterFlags == null || FilterFlags.Keys == null || !FilterFlags.Keys.Contains("ShowClosed"))
					return false;
				return FilterFlags["ShowClosed"]; }
			set { FilterFlags["ShowClosed"] = value; }
		}
		
		
	}
}
