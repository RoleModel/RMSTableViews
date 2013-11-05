//
//  RMSDynamicSection.h
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewSection.h"

@interface RMSDynamicSection : RMSTableViewSection

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSArray *representedObjects;

- (id)initWithTableView:(UITableView *)tableView cellIdentifier:(NSString *)cellIdentifier;

@end
