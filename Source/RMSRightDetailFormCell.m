//
//  RMSRightDetailFormCell.m

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSRightDetailFormCell.h"

@implementation RMSRightDetailFormCell

+ (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleValue1;
}

+ (instancetype)cell {
    RMSRightDetailFormCell *cell = [super cell];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)synchronizeView {
    [super synchronizeView];
    
    self.detailTextLabel.text = [self.value description];
}

@end
