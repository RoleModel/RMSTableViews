//
//  RMSModel.m
//  
//
//  Created by Tony Ingraldi on 6/25/13.
//
//

#import "RMSModel.h"

/*
 * Return the key with a lower case first character (i.e. ProfileId => profileId)
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
