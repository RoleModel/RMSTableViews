//
//  RMSFormSection.h
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

#import "RMSTableViewSection.h"

/*!
 \brief Represents a section of a UITableView managed by a RMSFormViewController.

 The RMSFormSection class represents a section of a UITableView managed by a RMSFormViewController.
 It manages the rows and textual headers and footers for the section.
 */
@interface RMSFormSection : RMSTableViewSection

/*!
 An array of RMSFormCell objects
 */
@property (nonatomic, strong) NSArray *rows;

- (id)initWithRows:(NSArray *)rows;
- (NSInteger)indexOfCell:(UITableViewCell *)cell;

/*!
 \brief Sent to a section after all properties specified in a form descriptor have been set.

 This message is sent to RMSFormSections by an RMSFormViewController after all properties
 specified for the section in the form descriptor have been set. RMSFormSection subclasses must 
 first call super when extending this method.
 */
- (void)awakeFromFormDescriptor;

@end
