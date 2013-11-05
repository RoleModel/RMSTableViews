//
//  RMSFormViewController.h
//
//  Created by Tony Ingraldi on 10/28/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewController.h"
#import "RMSFormCell.h"


extern NSString * const RMSFormKeySectionRows;

extern NSString * const RMSFormKeyCellClassName;
extern NSString * const RMSFormKeyProperties;
extern NSString * const RMSFormKeyBindVariable;
extern NSString * const RMSFormKeyEnabled;


/**
 \brief RMSFormViewController is a subclass of UITableViewController that generates its
 UITableView cells based on a declarative description.

 RMSFormViewController is intended to be used to manage UITableViews that have a fixed number of
 sections and rows (i.e. settings views, user registration views.)
 
 Cells used in the managed UITableView are specified
 declaritively in property list format. The property list representation of the 
 UITableView is referred to as the form descriptor.
 */
@interface RMSFormViewController : RMSTableViewController <RMSFormCellDelegate>

/*!
 \brief The dictionary used to interpret object references found in the form descriptor.

 The form descriptor can contain references to existing objects.
 These references are specified as string literals prefixed by a colon character. For example, if
 the literal string \b :someVariable is entered as a value in the form descriptor,
 then \b :someVariable must be present as a key in the dictionary
 returned by objectSubstitionDictionary.

 The default implementation returns nil. Subclasses must implement this method if the
 form descriptor used when the class is instantiated contains any colon-prefixed references.

 \note This method is invoked once just prior to UITableView cell generation.

 \return The object substitution dictionary.
 */
- (NSDictionary *)objectSubstitionDictionary;

/*!
 \brief Designated initializer for RMSFormViewController.

 \param style The UITableViewStyle to use for the table.
 \param descriptor The form descriptor to use when generating cells for the table. 
 
 \returns The RMSFormViewController instance.
 */
- (id)initWithStyle:(UITableViewStyle)style descriptor:(NSArray *)descriptor;

/*!
 \brief Initializer for RMSFormViewControllers described by a plist or JSON-formatted descriptor.

 \param style The UITableViewStyle to use for the table.
 \param descriptor The name of the file-based form descriptor. If a file extension is present 
 on the descriptorName, it must be either json or plist. If no extension is given, a resource 
 with a plist extension will be sought.
 
 \returns The RMSFormViewController instance.
 */
- (id)initWithStyle:(UITableViewStyle)style descriptorNamed:(NSString *)descriptorName;

@end
