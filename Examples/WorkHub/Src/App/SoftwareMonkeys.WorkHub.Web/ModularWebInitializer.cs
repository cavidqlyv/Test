using System;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.Web.Elements;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using SoftwareMonkeys.WorkHub.Web.Parts;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Used to initialize the standard and modular web components.
	/// </summary>
	// TODO: Move to .Web.Modules namespace
	public class ModularWebInitializer
	{
		public ModularWebInitializer()
		{
		}
		
		public void Initialize(Page page)
		{
			new ControllersInitializer().Initialize();
			new ElementsInitializer().Initialize();
    		
    		// Projections
    		ProjectionScanner[] projectionScanners = new ProjectionScanner[] {
    			new ProjectionScanner(new ControlLoader(page)),
    			new ModuleProjectionScanner(new ControlLoader(page))};
    				
    		new ProjectionsInitializer(page, projectionScanners).Initialize();
    				
    		// Parts
    		PartScanner[] partScanners = new PartScanner[] {
    				new PartScanner(page),
    				new ModulePartScanner(page)};
    	
    		new PartsInitializer(page, partScanners).Initialize();
			
		}
	}
}
