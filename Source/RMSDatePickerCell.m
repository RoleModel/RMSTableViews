//
//  RMSDatePickerCell.m

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDatePickerCell.h"
#import "RMSDatePickerViewController.h"

@implementation RMSDatePickerCell

- (void)synchronizeView {
    [super synchronizeView];
    
    if (self.value != nil) {
        self.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:self.value
                                                                   dateStyle:NSDateFormatterMediumStyle
                                                                   timeStyle:NSDateFormatterNoStyle];
    } else {
        self.detailTextLabel.text = nil;
    }
}

- (void)respondToSelection {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RMSDatePickerView" bundle:nil];
    RMSDatePickerViewController *pickerViewController = [storyboard instantiateInitialViewController];
    pickerViewController.title = self.labelText;
    pickerViewController.date = self.value;
    pickerViewController.completionBlock = ^(NSDate *date) {
        self.value = date;
    };

    if ([self.delegate respondsToSelector:@selector(formCell:pushViewController:)]) {
        [self.delegate formCell:self pushViewController:pickerViewController];
    }
}

@end
