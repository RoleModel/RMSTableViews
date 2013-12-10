//
//  RMSNamedColor.m
//
// Copyright (c) 2013 RoleModel Software, Inc
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
