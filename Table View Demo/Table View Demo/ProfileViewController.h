//
//  ProfileViewController.h
//

#import <UIKit/UIKit.h>
#import "RMSFormViewController.h"

@class RMSProfile;

@interface ProfileViewController : RMSFormViewController

@property (nonatomic, strong) RMSProfile *profile;
@property (nonatomic) BOOL inRegistrationMode;

@end
