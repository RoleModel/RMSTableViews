//
//  RMSProfileViewController.m
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
#import "RMSProfileViewController.h"
#import "RMSFormSection.h"
#import "RMSButtonCell.h"
#import "RMSSettingsViewController.h"
#import "RMSDynamicSection.h"
#import "RMSWordViewController.h"

@interface RMSProfileViewController ()

@property (nonatomic, strong) RMSButtonCell *saveButton;
@property (nonatomic, strong) RMSFormSection *accountSection;
@property (nonatomic, strong) NSString *passwordOne;
@property (nonatomic, strong) NSString *passwordTwo;

@end

@implementation RMSProfileViewController

#pragma mark plist object mapping

- (NSDictionary *)objectSubstitionDictionary {
    return @{
             @":profile" : self.profile,
             @":whiteColor" : [UIColor whiteColor],
             @":blackColor" : [UIColor blackColor],
             @":redColor" : [UIColor redColor],
             @":saveLabel" : self.inRegistrationMode ? @"Join" : @"Save",
             @":emailEnabled" : @(![self.profile isDefaultBool]),
             @":passwordsEnabled" : @(self.inRegistrationMode),
             @":deleteEnabled" : @(![self inRegistrationMode] && self.profile.canBeDeleted),
             @":genders" : @[@"male", @"female"]
             };
}

#pragma mark lifecycle

- (void)viewDidLoad {
    DLog(@"");
    [super viewDidLoad];

    self.saveButton.enabled = [self profileInformationIsValid];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(settingsButtonAction:)];
}

- (void)viewDidAppear:(BOOL)animated {
    DLog(@"");
    [super viewDidAppear:animated];

    [self startObserving];
}

- (void)dealloc {
    [self stopObserving];
}

- (void)startObserving {
    for (NSString *key in [RMSProfile attributes]) {
        [self.profile addObserver:self forKeyPath:key options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)stopObserving {
    for (NSString *key in [RMSProfile attributes]) {
        [self.profile removeObserver:self forKeyPath:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.title = self.profile.fullName;
    [self updateSaveButtonStatus];

    NSUInteger saveSectionIndex = [[self.tableView indexPathForCell:self.saveButton] section];

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:saveSectionIndex]
                  withRowAnimation:UITableViewRowAnimationNone];
}

- (void)updateSaveButtonStatus {
    self.saveButton.enabled = [self profileInformationIsValid];
}

- (void)updatePasswordMessage {
    [self updateSaveButtonStatus];
    NSString *existingFooter = self.accountSection.footerTitle ? self.accountSection.footerTitle : @"";

    if (self.passwordOne.length > 0 && self.passwordTwo.length > 0) {
        if (![self.passwordOne isEqualToString:self.passwordTwo]) {
            self.accountSection.footerTitle = @"Passwords don't match";
        } else if (self.passwordOne.length < 6) {
            self.accountSection.footerTitle = @"Passwords must be at least 6 characters long";
        } else {
            self.accountSection.footerTitle = @"";
        }
    } else {
        self.accountSection.footerTitle = @"";
    }

    if (![self.accountSection.footerTitle isEqualToString:existingFooter]) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[self.sections indexOfObject:self.accountSection]]
                      withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)setPasswordOne:(NSString *)passwordOne {
    _passwordOne = passwordOne;
    [self updatePasswordMessage];
}

- (void)setPasswordTwo:(NSString *)passwordTwo {
    _passwordTwo = passwordTwo;
    [self updatePasswordMessage];
}

#pragma mark actions

- (void)settingsButtonAction:(id)sender {
    RMSSettingsViewController *settingsViewController = [[RMSSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped descriptorNamed:@"RMSSettingsViewController.json"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)saveAction:(id)sender {
    if ([self profileInformationIsValid]) {
        if (self.inRegistrationMode) {
            [self registerUser];
        } else {
            [self save];
        }
    }
}

- (void)deleteAction:(id)sender {
    [self delete];
}

- (void)pushWordViewController {
    RMSWordViewController *wordViewController = [[RMSWordViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:wordViewController animated:YES];
}

#pragma mark real work would occur here

- (void)delete {
    [UIAlertView showAlertWithMessage:@"DELETE"];
}

- (void)save {
    [UIAlertView showAlertWithMessage:@"SAVE"];
}

- (void)registerUser {
    [UIAlertView showAlertWithMessage:@"REGISTER"];
}

#pragma mark validation, sort of

- (BOOL)profileInformationIsValid {
    BOOL profileInformationIsValid = [self.profile isValid];
    if (self.inRegistrationMode) {
        profileInformationIsValid = profileInformationIsValid && ([self validateEmail:self.profile.email] && [self passwordsArePossiblyValid]);
    }
    
    return profileInformationIsValid;
}

- (BOOL)passwordsArePossiblyValid {
    return (self.passwordOne.length >= 6 && [self.passwordOne isEqualToString:self.passwordTwo]);
}

- (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}" @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-" @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5" @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
