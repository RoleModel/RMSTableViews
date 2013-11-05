//
//  RMSTableViewCell.h
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMSTableViewCell <NSObject>

@optional

/*!
 \brief Sent to the receiver when the user selects the cell's row in a table view.
 */
- (void)respondToSelection;

@end