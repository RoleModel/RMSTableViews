//
//  RMSTableViewSection.h
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RMSTableViewSection : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;

- (NSInteger)rowCount;
- (UITableViewCell *)cellForIndex:(NSInteger)index;

@end
