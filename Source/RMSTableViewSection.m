//
//  RMSTableViewSection.m

//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewSection.h"

@implementation RMSTableViewSection

- (NSInteger)rowCount {
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Subclasses must implement rowCount"
                                 userInfo:nil];
}

- (UITableViewCell *)cellForIndex:(NSInteger)index {
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Subclasses must implement cellForIndex:"
                                 userInfo:nil];
}

@end
