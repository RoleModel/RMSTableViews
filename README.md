RMSTableViews 
===============

Provides common infrastructure for UITableViews via two UITableViewController subclasses and related support classes.

For form-like table views with a fixed number of rows, such as those found in settings views or those used to edit object data, the you'll want to subclass RMSFormViewController. For dynamic tables, you'll want to subclass RMSDynamicTableView.


Why?
====

Using either RMSFormViewController or RMSDynamicViewController frees you from the typical boilerplate code that is often found un UITableViewController subclasses. You'll end up with cleaner code that is easier to read and maintain.

Refer to "The Form Descriptor.md" to learn how to define the structure of an RMSFormViewController table using a plist or JSON. The Table View Demo project includes examples of both dynamic and form-like table views.