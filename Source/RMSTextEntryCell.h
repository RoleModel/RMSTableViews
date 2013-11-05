//
//  RMSTextEntryCell.h

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDataCell.h"
#import "RMSTextFieldObserver.h"

/*!
 \brief A subclass of RMSDataCell appropriate for managing string values
 */
@interface RMSTextEntryCell : RMSDataCell

@property (nonatomic, strong) NSNumber *secureTextEntry;

- (void)setNextTextEntryCell:(RMSTextEntryCell *)nextTextEntryCell withBlock:(void (^)())block;

@end
