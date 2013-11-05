//
//  RMSNamedColorPickerCell.m
//  Tabulator
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSNamedColorPickerCell.h"
#import "RMSNamedColor.h"

@implementation RMSNamedColorPickerCell

- (NSArray *)choices {
    return [RMSNamedColor namedColors];
}

- (void)arrayPickerController:(RMSArrayPickerController *)arrayPickerController willReturnCell:(UITableViewCell *)cell forObject:(id)object {
    RMSNamedColor *namedColor = (RMSNamedColor *)object;
    cell.textLabel.textColor = namedColor.color;
}

- (void)synchronizeView {
    [super synchronizeView];
    
    if (self.value) {
        RMSNamedColor *namedColor = (RMSNamedColor *)self.value;
        self.detailTextLabel.textColor = namedColor.color;
    }
}

@end
