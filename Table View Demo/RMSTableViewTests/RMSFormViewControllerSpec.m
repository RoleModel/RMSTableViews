//
//  RMSFormViewControllerSpec.m
//  Table View Demo
//
//  Created by Tony Ingraldi on 11/6/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSFormViewController.h"
#import "RMSFormSection.h"
#import "Kiwi.h"

static NSString * const RMSTestFormFirstSectionTitle = @"Account Information";
static NSString * const RMSTestFormSecondSectionTitle = @"General Information";

@interface RMSTestForm : RMSFormViewController

@property (nonatomic, strong) RMSFormSection *firstSection;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;

@end

@implementation RMSTestForm

- (NSDictionary *)objectSubstitionDictionary {
    return @{@":self" : self,
             @":genders" : @[@"male", @"female"]
             };
}

@end


SPEC_BEGIN(RMSFormViewControllerSpec)

describe(@"RMSFormViewControllerSpec", ^{

    context(@"when instantiated with a descriptor", ^{
        __block RMSTestForm *testForm = nil;
        NSArray *descriptor = @[
                                @{
                                    @"bindVariable" : @"firstSection",
                                    @"properties" : @{
                                            @"headerTitle" : RMSTestFormFirstSectionTitle
                                            },
                                    @"rows" : @[
                                            @{
                                                @"className" : @"RMSTextEntryCell",
                                                @"properties" : @{
                                                        @"keyPath" : @"firstName",
                                                        @"labelText" : @"First name",
                                                        @"representedObject" : @":self"
                                                        }
                                                },
                                            @{
                                                @"className" : @"RMSTextEntryCell",
                                                @"properties" : @{
                                                        @"keyPath" : @"lastName",
                                                        @"labelText" : @"Last name",
                                                        @"representedObject" : @":self"
                                                        }
                                                },
                                            ]
                                    },
                                @{
                                    @"properties" : @{
                                            @"headerTitle" : RMSTestFormSecondSectionTitle
                                            },
                                    @"rows" : @[
                                            @{
                                                @"className" : @"RMSArrayPickerCell",
                                                @"properties" : @{
                                                        @"choices" : @":genders",
                                                        @"keyPath" : @"gender",
                                                        @"labelText" : @"Gender",
                                                        @"representedObject" : @":self"
                                                        }
                                                },
                                            ]
                                    }];

        beforeAll(^{
            testForm = [[RMSTestForm alloc] initWithStyle:UITableViewStylePlain descriptor:descriptor];
        });

        it(@"should have two sections", ^{
            [[theValue([testForm.sections count]) should] equal:theValue(2)];
        });

        it(@"should have two rows in the first section", ^{
            [[theValue([testForm.sections[0] rowCount]) should] equal:theValue(2)];
        });

        it(@"should have one row in the second section", ^{
            [[theValue([testForm.sections[1] rowCount]) should] equal:theValue(1)];
        });

        it(@"should have the proper title on section one", ^{
            RMSFormSection *firstSection = testForm.sections[0];
            [[firstSection.headerTitle should] equal:RMSTestFormFirstSectionTitle];
        });

        it(@"should have the proper title on section two", ^{
            RMSFormSection *secondSection = testForm.sections[1];
            [[secondSection.headerTitle should] equal:RMSTestFormSecondSectionTitle];
        });

        it(@"should have firstSection bound to the first section", ^{
            RMSFormSection *firstSection = testForm.sections[0];
            [[testForm.firstSection should] equal:firstSection];
        });

        it(@"should return the expected cell types", ^{
            UITableViewCell *cell = [testForm tableView:testForm.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[NSStringFromClass([cell class]) should] equal:@"RMSTextEntryCell"];

            cell = [testForm tableView:testForm.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [[NSStringFromClass([cell class]) should] equal:@"RMSTextEntryCell"];

            cell = [testForm tableView:testForm.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            [[NSStringFromClass([cell class]) should] equal:@"RMSArrayPickerCell"];
        });
    });
});

SPEC_END