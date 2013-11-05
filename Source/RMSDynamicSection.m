//
//  RMSDynamicSection.m
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDynamicSection.h"
#import "RMSDynamicTableViewCell.h"

@implementation RMSDynamicSection

- (id)initWithTableView:(UITableView *)tableView cellIdentifier:(NSString *)cellIdentifier {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _cellIdentifier = cellIdentifier;
    }

    return self;
}

- (NSInteger)rowCount {
    return [self.representedObjects count];
}

- (UITableViewCell *)cellForIndex:(NSInteger)index {
    id cell = [self.tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if ([cell respondsToSelector:@selector(bindObject:)]) {
        [cell bindObject:self.representedObjects[index]];
    }

    return cell;
}

@end
