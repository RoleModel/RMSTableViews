//
//  RMSSwitchCell.m

//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSSwitchCell.h"

@implementation RMSSwitchCell

+ (instancetype)cell {
    RMSSwitchCell *cell = [super cell];

    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchView addTarget:cell action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = switchView;
    
    return cell;
}

- (void)synchronizeView {
    UISwitch *switchView = (UISwitch *)self.accessoryView;
    switchView.on = [self.value boolValue];
}

- (void)switchAction:(id)sender {
    UISwitch *switchView = (UISwitch *)sender;
    self.value = @(switchView.on);
}

@end
