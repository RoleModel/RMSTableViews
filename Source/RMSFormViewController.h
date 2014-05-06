//
//  RMSFormViewController.h
//
// Copyright (c) 2013 RoleModel Software, Inc
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "RMSTableViewController.h"
#import "RMSFormCell.h"

typedef NS_ENUM(NSInteger, RMSFormDescriptorType) {
    RMSFormDescriptorTypePlist,
    RMSFormDescriptorTypeJSON
};

extern NSString * const RMSFormKeySectionRows;

extern NSString * const RMSFormKeyClassName;
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
 In all cases, the base implementation will add a mapping for ":self" to the object
 substitution dictionary. The ":self" key is mapped to the RMSFormViewController instance.

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
 \param descriptorName The name of the file-based form descriptor.
 
 \note If a file extension is present
 on the descriptorName, it must be either json or plist. If no extension is given, a resource 
 with a plist extension will be sought.
 
 If descriptorName is not specified, the name of the
 descriptor will be derived from the name of the RMSFormViewController subclass. For example, a
 form descriptor named XYZFormViewController.plist will be assumed for a subclass named
 XYZFormViewController.
 
 \returns The RMSFormViewController instance.
 */
- (id)initWithStyle:(UITableViewStyle)style descriptorNamed:(NSString *)descriptorName;

/*!
 \brief Initializer for RMSFormViewControllers described by the supplied descriptor string.

 \param style The UITableViewStyle to use for the table.
 \param rawDescriptor The content of a plist- or JSON-formatted descriptor.
 \param descriptorType The type of the raw form descriptor.

 \returns The RMSFormViewController instance.
 */
- (id)initWithStyle:(UITableViewStyle)style rawDescriptor:(NSData *)rawDescriptor type:(RMSFormDescriptorType)descriptorType;

@end
