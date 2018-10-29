using System;

namespace SoftwareMonkeys.WorkHub.Configuration
{
	/// <summary>
	/// Description of IConfigurationDictionary.
	/// </summary>
	public interface ISerializableDictionary
	{	
		int Count { get; }
		
		//string[] Keys {get;}
		//object[] Values{get; }
		
		object this[string key] {get;set;}
		
		void Add(string key, object value);
		
		bool ContainsKey(string key);
		string[] GetKeys();
	}
}
