//
//  RMSNamedColor.m
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSNamedColor.h"

@implementation RMSNamedColor

+ (NSArray *)namedColors {
    static dispatch_once_t onceToken;
    static NSArray *_namedColors = nil;
    dispatch_once(&onceToken, ^{
        RMSNamedColor *red = [[RMSNamedColor alloc] initWithName:@"red" color:[UIColor redColor]];
        RMSNamedColor *blue = [[RMSNamedColor alloc] initWithName:@"blue" color:[UIColor blueColor]];
        RMSNamedColor *green = [[RMSNamedColor alloc] initWithName:@"green" color:[UIColor greenColor]];

        _namedColors = @[red, blue, green];

    });

    return _namedColors;
}

+ (RMSNamedColor *)colorForName:(NSString *)name {
    static NSMutableDictionary *_colorDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _colorDict = [NSMutableDictionary dictionary];
        for (RMSNamedColor *color in [self namedColors]) {
            _colorDict[color.name] = color;
        }
    });

    return _colorDict[name];
}

- (id)initWithName:(NSString *)name color:(UIColor *)color {
    self = [super init];
    if (self) {
        _name = name;
        _color = color;
    }

    return self;
}

- (NSString *)description {
    return self.name;
}

@end
