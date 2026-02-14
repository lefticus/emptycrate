---
layout: blog_post
title: Using Visual Studio Property Sheets to Manage Common Properties
published: true
date: '2009-04-30 05:00:00'
redirect_from:
- content/using-visual-studio-property-sheets-manage-common-properties/
- node/4377/
- import_node/421/
- node/421/
tags:
- Visual Studio
- Programming
---

Now that we have [built](/content/real-world-haskell-chapter-5) [Boost](http://www.boost.org) for Visual Studio, it sure would be handy to store the settings we need to use Boost in one place so that they can be easily set and reused. Visual Studio property sheets allow us to do just this. A property sheet is a collected set of settings which are stored in a .vsprops file. The file can be stored and reused between projects when common properties are desired. To create a property sheet for our Boost installation, we will first need to select the "Property Manager" tab of our project.  Next, right click on the project and choose "Add New Project Property Sheet..."  Now, choose the name and location of the property sheet that you would like to create. We are calling ours "boost.vsprops"  Then, right click on the new property sheet and choose "Properties." This will allow us to actually set the properties that the property sheet contains.  The goal of this particular property sheet is make Boost easy to use. We will need to configure the includes directory and library directory of Boost to accomplish this. Select "Common Properties -\> C/C++ -\> General" in the property tree and set the "Additional Include Directories" to include your Boost installation's header file directory.  Finally, you will need to set "Common Properties -\> Linker -\> General -\> Additional Library Directories" to include your Boost's library installation folder.  There, now we have created the Boost property sheet. Any time we want to use Boost from now on we just need to add this property sheet to our project and it will be ready to go. We can add many property sheets to our projects; so, we could create a library of property sheets for the various libraries that we regularly use.
