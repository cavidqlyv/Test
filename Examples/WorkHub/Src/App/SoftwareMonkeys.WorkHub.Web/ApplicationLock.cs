// This code is courtesy of:
// http://haacked.com/archive/2011/10/16/the-dangers-of-implementing-recurring-background-tasks-in-asp-net.aspx

using System;
using System.Web.Hosting;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Used to keep IIS from recycling the application while still active.
	/// </summary>
	public class ApplicationLock : IRegisteredObject
	{
		private readonly object _lock = new object();
		private bool _shuttingDown;

		public ApplicationLock()
		{
			HostingEnvironment.RegisterObject(this);
		}

		public void Stop(bool immediate)
		{
			lock (_lock)
			{
				_shuttingDown = true;
			}
			HostingEnvironment.UnregisterObject(this);
		}

		public void DoWork(Action work)
		{
			lock (_lock)
			{
				if (_shuttingDown)
				{
					return;
				}
				work();
			}
		}
	}
}
