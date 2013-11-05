//
//  RMSTargetActionCell.h
//  Tabulator
//
//  Created by Tony Ingraldi on 11/2/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSFormCell.h"

@interface RMSTargetActionCell : RMSFormCell

@property (nonatomic, strong) id target;
@property (nonatomic, strong) NSString *selectorString;

@end
