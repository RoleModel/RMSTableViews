//
//  RMSTableViewController.m
//  RMSTableViewController
//
//  Created by Tony Ingraldi on 11/4/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "Kiwi.h"
#import "RMSTableViewController.h"

SPEC_BEGIN(RMSTableViewControllerSpec)

describe(@"RMSTableViewController", ^{

    context(@"when instantiated", ^{
        __block RMSTableViewController *tableViewController = nil;

        beforeEach(^{
            tableViewController = [[RMSTableViewController alloc] init];
        });

        it(@"should have non-nil sections", ^{
            [[tableViewController.sections shouldNot] beNil];
        });
    });
});

SPEC_END