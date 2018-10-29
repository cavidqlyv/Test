using System;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Used to output text with spacers between them.
	/// </summary>
	public class TextSpacer
	{
		/*static public string Space(params string[] items)
		{
			return Space(" - ", items);
		}*/
		
		static public string Space(params string[] items)
		{
			string spacer = " - ";
			
			string output = String.Empty;
			int i = 0;
			foreach (string item in items)
			{
				if (item != null
				    && item.Trim() != String.Empty
				   && i < items.Length)
				{
					output = output + item + spacer;
				}
				
				i++;
			}
			
			output = output.Trim(' ').Trim('-');
			
			return output;
		}
	}
}
