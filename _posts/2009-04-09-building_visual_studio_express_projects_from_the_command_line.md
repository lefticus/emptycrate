---
layout: blog_post
title: Building Visual Studio Express Projects From the Command Line
published: true
date: '2009-04-09 05:00:00'
redirect_from:
- content/building-visual-studio-express-projects-command-line/
- node/4361/
- import_node/393/
tags:
- Visual Studio
- Programming
- C++
---

If you search around for how to build Visual Studio projects from the command line you will find references to the DevEnv executable. When working with Visual C++ Express, however, that tool does not exist.

An equivalent tool, vcbuild, does exist and can be used.

Start by opening the Visual Studio command prompt (Program Files->Microsoft Visual C++ 2008 Express Edition->Visual Studio Tools->Visual Studio 2008 Command Prompt).

Typing "vcbuild" gives you the command line help:

    Microsoft (R) Visual C++ Project Builder - Command Line Version 9.00.30729
    Copyright (C) Microsoft Corporation. All rights reserved.
    Usage: vcbuild [options] [project|solution] [config|$ALL]

    Options:
    /clean (/c)     Clean build outputs only
    /error:<str>    Prefix to add to error lines on output to stderr
    /errfile:<file> Log all errors to the file specified
    /htmllog:<file> Logs output to html file specified
                    (default: $(IntDir)\BuildLog.htm)
    /implib         Makes an import library for a DLL configuration (does not link)
    /info:<str>     Prefix to add to information lines on output to stdout
    /link (/l)      Performs a link without building sources
    /logcommands    Prints commands and response files to screen
    /logfile:<file> Log all output and build information to the file specified
    /override:<file>Override the project settings with the settings in the given
                    property sheet file

    /M<number>      Specifies the number of concurrent builds to run, if possible
    /msbuild:<opt>  Pass <opt> to msbuild.exe

    /nocolor        Do not output error and warning messages in color
    /nohtmllog      Do not write an html build log file

    /noimplib       Does not generate an import library.
                    NOTE: this option overrides /implib.
    /nologo         Suppress version and copyright message
    /nondefmsbuild  Do not use the copy of msbuild.exe located in the .NET
                    Frameworks installation
    /platform:<str> Build only configurations for the given platform
    /implibobjs:<s> Additional dependencies for the librarian
    /rebuild (/r)   Clean build outputs and perform a build
    /forcelink      Forces a link without building sources
    /showenv        Show environment in the html build log
    /time           Times the build from start to finish
    /upgrade        Upgrades the project file to the latest format supported
                    NOTE: the upgrade switch does not perform a build
                    NOTE: this option is ignored for solution files
    /useenv (/u)    Use environment variables for INCLUDE and LIB paths
    /overrideRefVer When upgrading, assume .NET Framework Version 3.5 for any assem
    ly references.
                    Requires /upgrade switch.
    /wrnfile:<file> Log all warnings to the file specified
    /warning:<str>  Prefix to add to warning lines on output to stdout
    @<file>         Read options from the specified response file

    Default Behavior:
    ===============================================================================
    If no project is specified, and there is only a single .vcproj file in the
    directory, that project will be built.
    If no configuration is specified, and the VCBUILD_DEFAULT_CFG environment
    variable is set, the configuration it specifies will be built. If it is not
    set, then all configurations will be built.

    The default action is to build the specified configurations without cleaning.

    Options will also be read from the VCBUILD_DEFAULT_OPTIONS environment
    variable.
    ===============================================================================
    
    
You can now use the tool to build your Visual Studio solution file:

    vcbuild.exe /rebuild CNC.sln "Release|Win32"
    
    