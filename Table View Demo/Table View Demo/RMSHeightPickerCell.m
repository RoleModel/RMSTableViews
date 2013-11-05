//
//  RMSHeightPickerCell.m
//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSHeightPickerCell.h"
#import "RMSHeightPickerViewController.h"

@implementation RMSHeightPickerCell

- (void)synchronizeView {
    [super synchronizeView];
    
    if (self.value) {
        NSInteger height = [self.value integerValue];
        self.detailTextLabel.text = [NSString stringWithFormat:@"%d' %d\"", height / 12, height % 12];
    } else {
        self.detailTextLabel.text = @"";
    }
}

- (void)respondToSelection {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RMSHeightPickerView" bundle:nil];
    RMSHeightPickerViewController *pickerViewController = [storyboard instantiateInitialViewController];
    pickerViewController.title = self.labelText;
    pickerViewController.height = self.value;
    pickerViewController.completionBlock = ^(NSNumber *height){
        self.value = height;
    };

    if ([self.delegate respondsToSelector:@selector(formCell:pushViewController:)]) {
        [self.delegate formCell:self pushViewController:pickerViewController];
    }
}

@end
