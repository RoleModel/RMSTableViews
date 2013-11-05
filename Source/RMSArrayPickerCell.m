//
//  RMSArrayPickerCell.m

//
//  Created by Tony Ingraldi on 10/25/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSArrayPickerCell.h"

@implementation RMSArrayPickerCell

- (void)respondToSelection {
    RMSArrayPickerController *arrayPickerController = [[RMSArrayPickerController alloc] init];
    arrayPickerController.delegate = self;
    arrayPickerController.title = self.labelText;
    arrayPickerController.selectedObject = self.value;
    arrayPickerController.choices = self.choices;
    arrayPickerController.dismissesOnSelection = YES;
    arrayPickerController.objectSelectedBlock = ^(id selectedObject){
        self.value = selectedObject;
    };

    if ([self.delegate respondsToSelector:@selector(formCell:pushViewController:)]) {
        [self.delegate formCell:self pushViewController:arrayPickerController];
    }
}

@end
