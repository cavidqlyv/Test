using System;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web.State
{
	/// <summary>
	/// Stores the state of the current user's suggestion filter preferences.
	/// </summary>
	static public class SuggestionFilterState
	{
		static private StateNameValueCollection<bool> filterFlags;
		static public StateNameValueCollection<bool> FilterFlags
		{
			get {
				if (filterFlags == null)
					filterFlags = new StateNameValueCollection<bool>(StateScope.Session, "Suggestions.SuggestionFilterFlags");
				
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
		
		static public bool ShowAccepted
		{
			get {
				if (FilterFlags == null || FilterFlags.Keys == null || !FilterFlags.Keys.Contains("ShowAccepted"))
					return false;
				return FilterFlags["ShowAccepted"]; }
			set { FilterFlags["ShowAccepted"] = value; }
		}
		
		
		static public bool ShowImplemented
		{
			get {
				if (FilterFlags == null || FilterFlags.Keys == null || !FilterFlags.Keys.Contains("ShowImplemented"))
					return false;
				return FilterFlags["ShowImplemented"]; }
			set { FilterFlags["ShowImplemented"] = value; }
		}
		
	}
}
