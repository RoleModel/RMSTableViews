//
//  RMSNavigationCell.m
//  Tabulator
//
//  Created by Tony Ingraldi on 11/2/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSNavigationCell.h"

@implementation RMSNavigationCell

+ (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleDefault;
}

+ (instancetype)cell {
    RMSNavigationCell *cell = [super cell];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

@end
