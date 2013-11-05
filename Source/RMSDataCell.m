//
//  RMSDataCell.m

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDataCell.h"



@interface RMSDataCell ()

@end


@implementation RMSDataCell

- (void)setValue:(id)value {
    [self.representedObject setValue:value forKeyPath:self.keyPath];
    [self synchronizeView];
}

- (id)value {
    return [self.representedObject valueForKeyPath:self.keyPath];
}

@end
