//
//  RMSSettingsViewController.m
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

#import "RMSSettingsViewController.h"

NSString * const RMSDefaultsAwesomeKey = @"AwesomeKey";
NSString * const RMSDefaultsPasswordExpirationDaysKey = @"PasswordExpirationDaysKey";
NSString * const RMSDefaultsFavoriteColorKey = @"FavoriteColorKey";

@interface RMSSettingsViewController ()

@property (nonatomic, readonly) NSUserDefaults *defaults;

@end


@implementation RMSSettingsViewController

- (NSDictionary *)objectSubstitionDictionary {
    return @{
             @":self" : self,
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(doneButtonAction:)];
}

- (void)doneButtonAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSUserDefaults *)defaults {
    return [NSUserDefaults standardUserDefaults];
}

- (NSNumber *)awesome {
    return [self.defaults objectForKey:RMSDefaultsAwesomeKey];
}

- (void)setAwesome:(NSNumber *)value {
    [self.defaults setObject:value forKey:RMSDefaultsAwesomeKey];
}

- (NSNumber *)passwordExpirationDays {
    return [self.defaults objectForKey:RMSDefaultsPasswordExpirationDaysKey];
}

- (void)setPasswordExpirationDays:(NSNumber *)value {
    [self.defaults setObject:value forKey:RMSDefaultsPasswordExpirationDaysKey];
}

- (void)setFavoriteColor:(RMSNamedColor *)value {
    [self.defaults setObject:value.name forKey:RMSDefaultsFavoriteColorKey];
}

- (RMSNamedColor *)favoriteColor {
    NSString *colorName = [self.defaults objectForKey:RMSDefaultsFavoriteColorKey];
    return [RMSNamedColor colorForName:colorName];
}

@end
