---
layout: blog_post
title: Getting the Output of an Application in Windows Script
published: true
date: '2009-04-07 05:00:00'
redirect_from:
- content/getting-output-application-windows-script
- node/4360
- import_node/392
tags:
- Windows Script
- Programming
---

If you are programming a Windows Script in VBScript and need to retrieve the output of an external command you can use the following simple function: ` Function GetCommandOutput(filename)  Dim WshShell, oExec  Set WshShell = CreateObject("WScript.Shell")  Set oExec    = WshShell.Exec(filename)   Do While oExec.Status <> 1    GetCommandOutput = GetCommandOutput & oExec.StdOut.ReadLine() & vbCrLf  Loop End Function`
