//
//  RMSNamedColor.h
//  Tabulator
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMSNamedColor : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;

+ (NSArray *)namedColors;
+ (RMSNamedColor *)colorForName:(NSString *)name;

- (id)initWithName:(NSString *)name color:(UIColor *)color;



@end
