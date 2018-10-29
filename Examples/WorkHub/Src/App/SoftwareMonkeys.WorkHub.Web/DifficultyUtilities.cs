using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.Properties;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Description of DifficultyUtilities.
	/// </summary>
	public class DifficultyUtilities
	{
		static public string GetDifficultyText(Difficulty difficulty)
		{
			return GetDifficultyText(difficulty, true);
		}
		
		static public string GetDifficultyText(Difficulty difficulty, bool allowHtml)
		{
			string output = Language.NotSet;
			
			string cssClass = difficulty.ToString();
			
			switch (difficulty)
			{
				case Difficulty.Extreme:
					output = Language.Extreme;
					break;
				case Difficulty.High:
					output = Language.High;
					break;
				case Difficulty.Moderate:
					output = Language.Moderate;
					break;
				case Difficulty.Low:
					output = Language.Low;
					break;
				case Difficulty.VeryLow:
					output = Language.VeryLow;
					break;
			}
			
			if (allowHtml)
				output  = "<span class='" + cssClass + "'>" + output + "</span>";
			
			return output;
		}
	}
}
