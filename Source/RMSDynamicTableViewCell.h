//
//  RMSDynamicTableViewCell.h
//
//  Created by Tony Ingraldi on 11/4/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewCell.h"

@protocol RMSDynamicTableViewCell <RMSTableViewCell>

@optional
/*!
 \brief Sent to the receiver when it is about to be presented by a dynamic table view.
 
 Implementations should set the state of the cell's views based on the properties of the
 supplied object.
 */
- (void)bindObject:(id)object;

@end
