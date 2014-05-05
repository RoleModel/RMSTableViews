//
//  RMSRedSection.m
//  Table View Demo
//
//  Created by Tony Ingraldi on 5/5/14.
//  Copyright (c) 2014 RoleModel Software, Inc. All rights reserved.
//

#import "RMSRedSection.h"

@implementation RMSRedSection

- (UITableViewCell *)cellForIndex:(NSInteger)index {
    UITableViewCell *cell = [super cellForIndex:index];

    cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];

    return cell;
}

@end
