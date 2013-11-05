//
//  RMSProfile.m
//
//  Created by Tony Ingraldi on 6/24/13.
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
