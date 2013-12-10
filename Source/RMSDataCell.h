//
//  RMSDataCell.h
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

#import <UIKit/UIKit.h>
#import "RMSFormCell.h"

/*!
 \brief A subclass of RMSFormCell intended data-editing purposes.

 \b RMSDataCells manage the state of a key-value coding compliant property on its represented object. 
 When the user changes the value presented by an RMSDataCell, the state of the represented object
 is modified by sending it a setValue:forKeyPath: message.
 
 RMSDataCells can be instantiated from a NIB or with one of the standard UITableViewCellStyles.
 Subclasses must implement +nibName if the cell is to be instantiated from a NIB.
 */
@interface RMSDataCell : RMSFormCell

@property (nonatomic, strong) id representedObject;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic) id value;

@end
