<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %> 
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">
    
    /// <summary>
    /// Gets/sets the current milestone being viewed. It's persisted via viewstate.
    /// </summary>
    protected Milestone CurrentMilestone
    {
        get { return (Milestone)ViewState["CurrentMilestone"]; }
        set { ViewState["CurrentMilestone"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (ProjectsState.EnsureProjectSelected())
            {
                switch (QueryStrings.Action)
                {
                    case "CreateMilestone":
                        CreateMilestone();
                        break;
                    case "ViewMilestone":
                        ViewMilestone(Utilities.GetQueryStringID("MilestoneID"));
                        break;
                    default:
                        ManageMilestones();
                        break;
                }
            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        IndexGrid.AddSortItem(Language.Deadline + " " + Language.Asc, "DeadlineAscending");
        IndexGrid.AddSortItem(Language.Deadline + " " + Language.Desc, "DeadlineDescending");
                
        base.OnInit(e);
        
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing milestones.
    /// </summary>
    public void ManageMilestones()
	{
		ManageMilestones(0);
	}

    /// <summary>
    /// Displays the index for managing milestones.
    /// </summary>
    public void ManageMilestones(int pageIndex)
    {

        IndexGrid.CurrentPageIndex = pageIndex;

        OperationManager.StartOperation("ManageMilestones", IndexView);

		int total = 0;
        Milestone[] milestones = null;

		if (ProjectsState.EnsureProjectSelected())
        {
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);

			milestones = IndexStrategy.New<Milestone>(location, IndexGrid.CurrentSort).IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
		
			ActivateStrategy.New<Milestone>().Activate(milestones, "Tasks");
		
			IndexGrid.VirtualItemCount = location.AbsoluteTotal;
			IndexGrid.DataSource = milestones;
	        // TODO: Add sorting code
	
	        // TODO: Fix security check
	        Authorisation.UserCan("View", milestones);
	
	        IndexView.DataBind();
		}
    }

    /// <summary>
    /// Displays the form for creating a new milestone.
    /// </summary>
    public void CreateMilestone()
    {
		Response.Redirect(UrlCreator.Current.CreateUrl("Create", typeof(Milestone).Name));
    }

    /// <summary>
    /// Displays the details of the milestone with the specified ID.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to display.</param>
    private void ViewMilestone(Guid milestoneID)
    {

        Response.Redirect(UrlCreator.Current.CreateUrl("View", typeof(Milestone).Name));
    }


    /// <summary>
    /// Moves the milestone with the provided ID up one position.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to move.</param>
    private void MoveMilestoneUp(Guid milestoneID)
    {
        // Load the milestone
        Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);
        
        // TODO: Check if there is a more efficient way to do this
        ActivateStrategy.New<Milestone>().Activate(milestone, "Project");

        Guid projectID = milestone.Project.ID;
        
        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", milestone);

        // Move the milestone
        MoveMilestoneStrategy.New().MoveUp(milestone.ID);

        // Display the result
        Result.Display(Language.MilestoneUpdated);

        	Navigator.Go("Roadmap");
       
    }

    /// <summary>
    /// Moves the milestone with the provided ID down one position.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to move.</param>
    private void MoveMilestoneDown(Guid milestoneID)
    {
        // Load the milestone
        Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);

        // TODO: Check if there is a more efficient way to do this
        ActivateStrategy.New<Milestone>().Activate(milestone, "Project");
        
        Guid projectID = milestone.Project.ID;
        
        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", milestone);

        // Move the milestone
        MoveMilestoneStrategy.New().MoveDown(milestone.ID);

        // Display the result
        Result.Display(Language.MilestoneUpdated);

        	Navigator.Go("Roadmap");
       
    }

    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new milestone
        CreateMilestone();
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            ViewMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveUp")
        {
            MoveMilestoneUp(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveDown")
        {
            MoveMilestoneDown(new Guid(e.CommandArgument.ToString()));
        }
    }
    
    protected void PrerequisitesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    protected void ViewPrerequisitesGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
    	// TODO: Check if needed. Remove if not.
       // if (e.CommandName == "Edit")
       // {
       //     EditMilestone(new Guid(e.CommandArgument.ToString()));
       // }
       // else if (e.CommandName == "Delete")
       // {
       //     DeleteMilestone(new Guid(e.CommandArgument.ToString()));
       // }
       if (e.CommandName == "View")
       {
            ViewMilestone(new Guid(e.CommandArgument.ToString()));
       }
    }

    	// TODO: Check if needed. Remove if not.
	/*private Task[] GetMilestoneTasks(Milestone milestone)
	{
		// TODO: Check if Activate function should take care of this
		Task[] tasks = null;
		if (milestone.Tasks != null && milestone.Tasks.Length > 0)
			tasks = milestone.Tasks;
		else
			tasks = TaskFactory.Current.GetTasks(milestone.TaskIDs);

		foreach (Task task in tasks)
		{
			if (task.SubTasks == null)
			{
				task.SubTasks = TaskFactory.Current.GetTasks(task.SubTaskIDs);
			}
		}

		return tasks;
	}*/

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageMilestones(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageMilestones(e.NewPageIndex);
    }
    
    private Guid GetPreviousMilestoneID(Guid milestoneID)
    {
    	Milestone[] milestones = (Milestone[])IndexGrid.DataSource;
    	
    	Milestone previousMilestone = null;
    	
    	for (int i = 0; i < milestones.Length; i++)
    	{
    		Guid id = milestones[i].ID;
    		
    		if (id.ToString().Equals(milestoneID.ToString()) && i > 0)
    			previousMilestone = milestones[i-1];
    		
    	}
    	
    	if (previousMilestone != null)
	    	return previousMilestone.ID;
	    else
	    	return Guid.Empty;
    }
    
    private Guid GetNextMilestoneID(Guid milestoneID)
    {
    	Milestone[] milestones = (Milestone[])IndexGrid.DataSource;
    	
    	Milestone nextMilestone = null;
    	
    	for (int i = 0; i < milestones.Length; i++)
    	{
    		Guid id = milestones[i].ID;
    		
    		if (id.ToString().Equals(milestoneID.ToString()) && i < milestones.Length-1)
    			nextMilestone = milestones[i+1];
    		
    	}
    	
    	if (nextMilestone != null)
	    	return nextMilestone.ID;
	    else
	    	return Guid.Empty;
    }
   
   private Guid GetMilestoneID(Control container)
   {
   		return (Guid)DataBinder.Eval(DataBinder.Eval(container, "Parent.Parent.Parent.DataItem"), "ID");
   }
   
   private void TaskItem_ItemCreated(object sender, RepeaterItemEventArgs e)
   {
   			HyperLink previousItem = (HyperLink)e.Item.FindControl("PreviousLink");
   			if (previousItem != null)
   				previousItem.Attributes["onclick"] = "return confirm('" + Language.ConfirmMoveTaskToPreviousMilestone + "');";
   			HyperLink nextItem = (HyperLink)e.Item.FindControl("NextLink");
   			if (nextItem != null)
   				nextItem.Attributes["onclick"] = "return confirm('" + Language.ConfirmMoveTaskToNextMilestone + "');";
   }
   
   private string GetPreviousLink(Control container, Task task)
   {
   		return Navigator.GetLink("MoveToMilestone", task)
   			+ "?MilestoneID=" + GetPreviousMilestoneID(GetMilestoneID(container))
   			+ "&FromMilestoneID=" + GetMilestoneID(container);
   }
   
   private string GetNextLink(Control container, Task task)
   {
   		return Navigator.GetLink("MoveToMilestone", task)
   			+ "?MilestoneID=" + GetNextMilestoneID(GetMilestoneID(container))
   			+ "&FromMilestoneID=" + GetMilestoneID(container);
   }
   
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Roadmap;
  	MenuCategory = Language.Development;
  }    
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.Roadmap %>
                    </div>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.RoadmapIntro %>
                        </p>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="MilestoneNumberAscending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Roadmap %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="False" Width="100%"
                            EmptyDataText='<%# Language.NoMilestonesForProject %>' OnItemCommand="IndexGrid_ItemCommand" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged"
                            ItemMouseOverCssClass="ListItem" ItemMouseOutCssClass="ListItem"
                            >
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    		<table style="border-collapse: collapse;" width="100%">
                                    			<tr>
                                    				<td height="100%" style="padding-right: 2px; width: 20px; border: none;">
		                                    			<div><%# Eval("MilestoneNumber") %>.</div>
					                                    <asp:placeholder runat="server" visible='<%# Eval("Description") != String.Empty %>'>
					                                    <div>&nbsp;</div>
					                                    </asp:placeholder>
		                                    		</td>
		                                    		<td height="100%" width="98%" style="border:none;" onmouseover="this.className='ListItemOver';"  onmouseout="this.className='ListItem';">
			                                    			<asp:HyperLink runat="server" text='<%# Eval("Title") %>' NavigateUrl='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'></asp:HyperLink><%# (bool)Eval("EnableDeadline") ? " - " + Utilities.GetRelativeDate((DateTime)Eval("Deadline")) : String.Empty %></div>
			                                    			<asp:placeholder runat="server" visible='<%# Eval("Description") != null && Eval("Description") != String.Empty %>'>
															<div style="padding: 3px 0px 3px 0px">
																<%# (String)Eval("Description") %>
															</div>
															</asp:placeholder>
													</td>
													<td style="width: 20px;" class="Actions">
													<asp:LinkButton ID="MoveUpButton" CommandArgument='<%# Eval("ID") %>' runat="server" enabled='<%# (int)Eval("MilestoneNumber") > 1 %>' text='<%# Language.Up %>' ToolTip='<%# Language.MoveMilestoneUpToolTip %>' CommandName="MoveUp"></asp:LinkButton><br/>
													<asp:LinkButton ID="MoveDownButton" CommandArgument='<%# Eval("ID") %>' ToolTip='<%# Language.MoveMilestoneDownToolTip %>' runat="server" enabled='<%# (int)Eval("MilestoneNumber") < ((Milestone[])IndexGrid.DataSource).Length %>' text='<%# Language.Down %>' CommandName="MoveDown"></asp:LinkButton>
													</td>
													</tr>
													<tr>
													<td colspan="2">
														<div style="padding: 0px 0px 0px 13px">
															<asp:Repeater runat="server" datasource='<%# Eval("Tasks") %>' OnItemCreated='TaskItem_ItemCreated'>
																<HeaderTemplate>
																	<table style="padding: 0px; border-collapse: collapse; width: 100%;">
																</HeaderTemplate>
																<ItemTemplate>
																	<tr>
																		<td colspan="2" style="padding: 0px;">
					                                    					<hr/>
																		</td>
																		<tr onmouseover="this.className='ListItemOver';"  onmouseout="this.className='ListItem';">
																		<td style="padding:0px; width: 95%;">
							 												<div style='padding: 0px 3px 0px 3px;'>
							                                     				<div style="padding: 3px 0px 1px 0px"><a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'><%# Eval("Title") %></a></div>
							                                     				<div>
							                                     					<span class="Details">
							                                     							<%# Language.Status %>:
							                                     						<%# TaskStatusUtilities.GetStatusText((TaskStatus)Eval("Status")) %>
							                                     						&nbsp;&nbsp;&nbsp;<%# Language.Priority %>:
							                                     						<%# PriorityUtilities.GetPriorityText((Priority)Eval("Priority")) %>
							                                     						&nbsp;&nbsp;&nbsp;<%# Language.Difficulty %>:
							                                     						<%# DifficultyUtilities.GetDifficultyText((Difficulty)Eval("Difficulty")) %>
							                                     					</span>
							                                     				</div>
							                                    				<div><%# Utilities.Summarize((string)Eval("Description"), 200) %></div>
							                                    				
						                                    				</div>
					                                    				</td>
					                                    				<td style='width: 150px; text-align:right;'>
					                                    						<asp:Hyperlink id="PreviousLink" runat="server" enabled='<%# !GetPreviousMilestoneID(GetMilestoneID(Container)).Equals(Guid.Empty) %>' NavigateUrl='<%# GetPreviousLink(Container, (Task)Container.DataItem) %>' alt="<%= Language.MoveTaskToPreviousMilestoneToolTip %>" text='<%# "&laquo;&nbsp;" + Language.Prev %>'/>
					                                    						<br/>
					                                    						<a href='<%# Navigator.GetLink("RemoveFromMilestone", (IEntity)Container.DataItem) + "?MilestoneID=" + GetMilestoneID(Container) %>' onclick="return confirm('<%= Language.ConfirmRemoveTaskFromMilestone %>');" alt="<%= Language.RemoveTaskFromMilestoneToolTip %>"><%= Language.Remove %></a>
					                                    						<br/>
					                                    						<asp:Hyperlink id="NextLink" runat="server" enabled='<%# !GetNextMilestoneID(GetMilestoneID(Container)).Equals(Guid.Empty) %>' NavigateUrl='<%# GetNextLink(Container, (Task)Container.DataItem) %>' alt="<%= Language.MoveTaskToNextMilestoneToolTip %>" text='<%# Language.Next + "&nbsp;&raquo;" %>'/>
					                                    				</td>
				                                    				</tr>
				                                				</ItemTemplate>
				                                				<FooterTemplate>
				                                					</table>
				                                				</FooterTemplate>
				                                			</asp:Repeater>
				                                		</div>
		                                			</td>
		                                		</tr>
		                                	</table>
		                                	<hr/>
									</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
    </asp:MultiView>
