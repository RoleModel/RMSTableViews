//
//  RMSWordCell.m
//
//  Created by Tony Ingraldi on 11/4/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSWordCell.h"

@implementation RMSWordCell

- (void)bindObject:(id)object {
    self.textLabel.text = object;
}

@end
