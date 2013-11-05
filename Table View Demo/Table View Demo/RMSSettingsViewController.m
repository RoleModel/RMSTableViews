//
//  RMSSettingsViewController.m
//  Tabulator
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSSettingsViewController.h"

NSString * const RMSDefaultsAwesomeKey = @"com.rolemodelsoftware.tabulator.awesome";
NSString * const RMSDefaultsPasswordExpirationDaysKey = @"com.rolemodelsoftware.tabulator.passwordExpirationDays";
NSString * const RMSDefaultsFavoriteColorKey = @"com.rolemodelsoftware.tabulator.favoriteColor";

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
