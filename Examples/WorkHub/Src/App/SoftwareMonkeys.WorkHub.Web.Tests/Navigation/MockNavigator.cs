using System;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.Web.Navigation;
using SoftwareMonkeys.WorkHub.Tests;

namespace SoftwareMonkeys.WorkHub.Web.Tests.Navigation
{
	/// <summary>
	/// A mock navigator for use during testing.
	/// </summary>
	public class MockNavigator : Navigator
	{	
		private BaseTestFixture executingTestFixture;
		public BaseTestFixture ExecutingTestFixture
		{
			get { return executingTestFixture; }
			set { executingTestFixture = value; }
		}
		
		private bool didNavigate;
		/// <summary>
		/// Gets/sets a value indicating whether the mock navigation has been triggered.
		/// </summary>
		public bool DidNavigate
		{
			get { return didNavigate; }
			set { didNavigate = value; }
		}
		
		private string navigateLink = String.Empty;
		/// <summary>
		/// Gets/sets the navigate link that the navigator would redirect to (if outside unit tests).
		/// </summary>
		public string NavigateLink
		{
			get { return navigateLink; }
			set { navigateLink = value; }
		}
		
		private string entityType = String.Empty;
		public string EntityType
		{
			get { return entityType; }
			set { entityType = value; }
		}
		
		public MockNavigator(Control parent, string typeName, BaseTestFixture executingTestFixture) : base(parent)
		{
			ExecutingTestFixture = executingTestFixture;
			EntityType = typeName;
			UrlCreator = new MockUrlCreator(executingTestFixture);
		}
		
		public override void Redirect(string link)
		{
			NavigateLink = link;
			
			DidNavigate = true;
		}
		
		public override string GetEntityType()	
		{
			if (EntityType == String.Empty)
				throw new InvalidOperationException("The EntityType property hasn't been set.");
			return EntityType;
		}
	}
}
