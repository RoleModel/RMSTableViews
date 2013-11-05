//
//  RMSArrayPickerCell.h

//
//  Created by Tony Ingraldi on 10/25/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSRightDetailFormCell.h"
#import "RMSArrayPickerController.h"

/*!
 \brief A subclass of RMSRightDetailFormCell appropriate for managing values to be selected from an array of choices.
 
 RMSArrayPickerCells enable the user to select a value from an array of pre-defined choices. The choices
 are presented by an RMSArrayPickerController.
 */
@interface RMSArrayPickerCell : RMSRightDetailFormCell <RMSArrayPickerControllerDelegate>

@property (nonatomic, strong) NSArray *choices;

@end
