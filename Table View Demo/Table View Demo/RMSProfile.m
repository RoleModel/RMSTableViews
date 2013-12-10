//
//  RMSProfile.m
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

#import "RMSProfile.h"

@implementation RMSProfile

+ (NSArray *)attributes {
    static NSArray *_attributes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _attributes = @[
                        @"profileId",
                        @"email",
                        @"firstName",
                        @"lastName",
                        @"initial",
                        @"city",
                        @"state",
                        @"birthday",
                        @"gender",
                        @"height",
                        @"handicap",
                        @"stance",
                        @"isDefault"
                        ];
    });

    return _attributes;
}

- (NSString *)fullName {
    if (self.firstName != nil && self.lastName != nil) {
        return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    } else {
        if (self.lastName != nil) {
            return [NSString stringWithFormat:@"%@", self.lastName];
        } else if (self.firstName != nil) {
            return [NSString stringWithFormat:@"%@", self.firstName];
        } else {
            return @"";
        }
    }
}

- (void)setBirthday:(NSDate *)birthday {
    if ([birthday isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSDate *date;
        NSRange range = NSMakeRange(0, [(NSString *)birthday length]);
        NSError *error = nil;
        [dateFormatter getObjectValue:&date forString:(NSString *)birthday range:&range error:&error];
        if (error != nil) {
            DLog(@"Failed to parse date string: %@", birthday);
            birthday = nil;
        } else {
            birthday = date;
        }
    }
    _birthday = birthday;
}

+ (NSSet *)keyPathsForValuesAffectingValid {
    return [NSSet setWithArray:@[@"firstName", @"lastName"]];
}

- (BOOL)isValid {
    return ([self.firstName length] > 0 && [self.lastName length] > 0);
}

- (BOOL)canBeDeleted {
    return ![self isDefaultBool] && (self.profileId != nil);
}

- (BOOL)isDefaultBool {
    return [self.isDefault boolValue];
}

@end
