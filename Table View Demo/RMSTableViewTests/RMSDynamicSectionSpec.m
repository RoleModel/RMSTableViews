//
//  RMSDynamicSectionSpec.m
//  Table View Demo
//
//  Created by Tony Ingraldi on 11/6/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//


#import "RMSDynamicSection.h"
#import "Kiwi.h"

SPEC_BEGIN(RMSDynamicSectionSpec)

describe(@"RMSDynamicSectionSpec", ^{

    context(@"when configured with data", ^{
        __block RMSDynamicSection *dynamicSection = nil;
        NSArray *data = @[@"one"];

        beforeEach(^{
            dynamicSection = [[RMSDynamicSection alloc] initWithTableView:nil cellIdentifier:nil];
            dynamicSection.representedObjects = data;
        });

        it(@"should have rowCount equal to the count of the data", ^{
            [[theValue([dynamicSection rowCount]) should] equal:theValue([data count])];
        });
    });
});

SPEC_END