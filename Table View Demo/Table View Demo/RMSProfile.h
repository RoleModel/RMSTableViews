//
//  RMSProfile.h
//
//  Created by Tony Ingraldi on 6/24/13.
//

#import <Foundation/Foundation.h>
#import "RMSModel.h"

@interface RMSProfile : RMSModel

@property (nonatomic) NSString *profileId;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *initial;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSDate *birthday;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSNumber *height;
@property (nonatomic) NSNumber *handicap;
@property (nonatomic) NSString *stance;
@property (nonatomic) NSNumber *isDefault;

@property (nonatomic) BOOL canBeDeleted;
@property (nonatomic) BOOL isDefaultBool;

- (NSString *)fullName;
- (BOOL)isValid;

@end
