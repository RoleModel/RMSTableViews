//
//  RMSModel.m
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

#import "RMSModel.h"

/*
 * Return the key with a lower case first character (i.e. FirstName => firstName)
 */
NSString *normalize(NSString *key) {
    NSString *normalizedKey = nil;
    if ([key length]) {
        NSString *firstChar = [key substringToIndex:1];
        normalizedKey = [NSString stringWithFormat:@"%@%@", [firstChar lowercaseString], [key substringFromIndex:1]];
    }
    
    return normalizedKey;
}

@implementation RMSModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    DLog(@"%@", dictionary);
    self = [super init];
    if (self) {
        NSMutableDictionary *normalizedDictionary = [NSMutableDictionary dictionaryWithCapacity:[dictionary count]];
        for (NSString *key in dictionary) {
            normalizedDictionary[normalize(key)] = dictionary[key];
        }
        NSArray *attributes = [[self class] attributes];
        DLog(@"attributes: %@", attributes);
        for (NSString *key in attributes) {
            [self setValue:normalizedDictionary[key]
                    forKey:key];
        }
    }
    return self;
}

- (NSString *)description {
    return [[self asDictionary] description];
}

+ (NSArray *)attributes {
    return @[];
}

+ (NSArray *)truthyStringValues {
    static NSArray *_truthyStringValues = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _truthyStringValues = @[
                        @"true",
                        @"TRUE",
                        @"YES",
                        @"yes",
                        @"Y",
                        @"y",
                        @"ON",
                        @"on",
                        @"1",
                        ];
    });
    
    return _truthyStringValues;
}

- (NSDictionary *)asDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *attributes = [[self class] attributes];
    for (NSString *key in attributes) {
        id value = [self valueForKey:key];
        if (value != nil) {
            dictionary[key] = value;
        } else {
            dictionary[key] = @"";
        }
    }
    
    return dictionary;
}

- (void)setNilValueForKey:(NSString *)key {
    DLog(@"ignoring nil value for %@", key);
    // ignore for now, maybe forever
}

@end
