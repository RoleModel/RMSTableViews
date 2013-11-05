//
//  RMSFormSection.m

//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSFormSection.h"

@implementation RMSFormSection

- (instancetype)initWithRows:(NSArray *)rows {
    self = [super init];
    if (self) {
        _rows = rows;
    }

    return self;
}

- (NSInteger)rowCount {
    return [self.rows count];
}

- (NSInteger)indexOfCell:(UITableViewCell *)cell {
    return [self.rows indexOfObject:cell];
}

- (UITableViewCell *)cellForIndex:(NSInteger)index {
    return [self.rows objectAtIndex:index];
}

@end
