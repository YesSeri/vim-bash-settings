#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.TitleBar\workspacer.TitleBar.dll"


using workspacer;
using workspacer.Bar;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;
using workspacer.TitleBar;

using System.Collections.Generic;
using System.Linq;
using workspacer.Bar.Widgets;

using System;
using System.IO;
using System.Text;

Action<IConfigContext> doConfig = (context) =>
{

	string path = @"C:\Users\Henrik\.workspacer\config.log";
	File.WriteAllText(path, "");

	// var background = new Color(0x0, 0x0, 0x0);
	var barPluginConfig = new BarPluginConfig()
	{
		// DefaultWidgetBackground = background,
		LeftWidgets = () => new IBarWidget[]
		{
			new WorkspaceWidget(), new TextWidget(": "), new TitleWidget() {
				IsShortTitle = true
			}
		},
		RightWidgets = () => new IBarWidget[]
		{
			new BatteryWidget(),
			new TimeWidget(1000, "HH:mm dd"),
			new ActiveLayoutWidget(),
	  }
	};
	context.AddBar(barPluginConfig);
	// Uncomment to switch update branch (or to disable updates)
    //context.Branch = Branch.None;


    // context.AddBar();
	var focusIndicatorPluginConfig = new FocusIndicatorPluginConfig();
	focusIndicatorPluginConfig.TimeToShow = 1000;
	focusIndicatorPluginConfig.BorderColor = new Color(0x70, 0xd0, 0x00);
    context.AddFocusIndicator(focusIndicatorPluginConfig);
	var actionMenu = context.AddActionMenu();
	// actionMenu.Add("firefox", () => System.Diagnostics.Process.Start("CMD.exe", "start firefox"));

	actionMenu.DefaultMenu.Add("firefox", () => System.Diagnostics.Process.Start("powershell.exe", "start firefox"));
	actionMenu.DefaultMenu.AddFreeForm("run path", (s) => {
			System.Diagnostics.Process.Start("powershell.exe", "start " + s);
	});
	// w=web, m=main, d=docs, t=terminal, c=communcations
    context.WorkspaceContainer.CreateWorkspaces("w", "m", "d", "t", "c");

    // context.WorkspaceContainer.CreateWorkspaces("1", "2", "3");
    context.CanMinimizeWindows = true; // false by default
	context.WindowRouter.AddRoute((window) =>
	{
	// Writer is used to find program names.
		// using (StreamWriter sw = File.AppendText(path))
		{
			// sw.WriteLine(window.Title);
			if (window.Title.Contains("Mozilla Firefox") || window.Title.Contains("Chrome"))
			{
				return context.WorkspaceContainer["w"];
			}
			if (window.Title.Contains("Discord") || window.Title.Contains("WhatsApp"))
			{
				return context.WorkspaceContainer["c"];
			}
			if (window.Title.Contains("Windows Terminal") || window.Title.Contains("cmd") || window.Title.Contains("PowerShell"))
			{
				return context.WorkspaceContainer["t"];
			}
			if (window.Title.Contains("Maple") || window.Title.Contains("Visual Studio Code"))
			{
				return context.WorkspaceContainer["m"];
			}
			return null;
		}
	});

	
	string browserCmd;
    browserCmd = "/C start firefox";
 
	KeyModifiers mod = KeyModifiers.Alt;
	 // Alt + B = Chrome
    // context.Keybinds.Subscribe(mod, workspacer.Keys.B, () => System.Diagnostics.Process.Start("CMD.exe", browserCmd), "open firefox");

 

};
return doConfig;
