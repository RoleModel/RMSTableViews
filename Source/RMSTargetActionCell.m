//
//  RMSTargetActionCell.m
//
//  Created by Tony Ingraldi on 11/2/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTargetActionCell.h"

@interface RMSTargetActionCell ()

@property (nonatomic, strong) NSInvocation *invocation;
@property (nonatomic) SEL action;

@end


@implementation RMSTargetActionCell

- (NSInvocation *)invocation {
    if (_invocation == nil) {
        SEL action = NSSelectorFromString(self.selectorString);
        _invocation = [NSInvocation invocationWithMethodSignature:[[self.target class] instanceMethodSignatureForSelector:action]];
        _invocation.target = self.target;
        _invocation.selector = action;
    }

    return _invocation;
}

- (void)respondToSelection {
    [self.invocation invoke];
}

@end
