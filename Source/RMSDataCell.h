//
//  RMSDataCell.h

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
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
