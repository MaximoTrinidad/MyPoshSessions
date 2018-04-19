<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.129
	 Created on:   	12/05/2016 2:30 PM
	 Created by:   	Maximo Trinidad
	 Organization: 	PutItTogether
	 Filename:    CrossPlatTest2.ps1 	
	===========================================================================
	.DESCRIPTION
		Create list of Linux packages to be installed/upgraded.

#>
#requires -Version 6

function Get-DebianAptUpgradable{
	[CmdletBinding()]
	Param(
		[string] $outpath
	)

	begin
	{
		#$outpath = '/mnt/c/Users/mtrinidad/OneDrive/MyDocs/MyCrossPlatCode/CrossPlatScripts/';
		$todaydate = $((get-date).ToString("yyyyHHmmsss"));
		$outreport = "WSL_AptList_Upgradable_$($todaydate).csv";
		$outreport2 = "WSL_AptList_Upgradable2_$($todaydate).csv";
		$reportfullpath = $outpath+$outreport;
		$reportfullpath2 = $outpath+$outreport2;
	}
	process
	{
		if($IsLinux -eq $true)
		{
				Write-Verbose "Linux Selected - creating list" -Verbose;
				apt list --upgradable | tee $reportfullpath | Out-Null;			
				
				$upgradelist = Get-Content -path $reportfullpath -Encoding UTF8;

				[array]$aptupg = foreach($i in $upgradelist)
				{ 
					$i.split('/').split(',').split(' ')[0];
				};
				
				$aptupg | Out-file -FilePath $reportfullpath2;		
		}
		else
		{
			Write-Host "Execute only in Linux OS!";
			$notLinux = 1;
		};
	};
	end
	{
		if($notLinux -eq 1)
		{
			Write-Host "Function will not execute in Linux";
		}
		else
		{
			Write-Host "Process Completed!";
		};
	};
};

Get-DebianAptUpgradable -outpath '/mnt/c/Temp/';

## - Execute in either Bash or Linux:
#sudo apt list --upgradable | tee /mnt/c/Temp/WSL_AptList_Upgradable_Apps.csv

## - From Windows to execute: Windows (error)
#. 'C:\Users\max_t\Documents\SAPIEN\PowerShell Studio\Files\Events_Sessions_2018\WhatsCookingWithPSCore6\DemoScript\CrossPlatTest2.ps1'

## - From Bash to execute from PowerShell: 
#. '/mnt/c/Users/max_t/Documents/SAPIEN/PowerShell Studio/Files/Events_Sessions_2018/WhatsCookingWithPSCore6/DemoScript/CrossPlatTest2.ps1'