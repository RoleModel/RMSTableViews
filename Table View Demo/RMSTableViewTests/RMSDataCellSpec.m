//
//  RMSDataCellSpec.m
//  Table View Demo
//
//  Created by Tony Ingraldi on 11/7/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSDataCell.h"
#import "Kiwi.h"

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;

@end

@implementation Person

@end


SPEC_BEGIN(RMSDataCellSpec)

describe(@"RMSDataCellSpec", ^{

    context(@"when configured", ^{
        __block RMSDataCell *dataCell = nil;
        __block Person *person = nil;

        beforeAll(^{
            person = [[Person alloc] init];
            person.firstName = @"Mahershalalhashbaz";

            dataCell = [RMSDataCell cell];
            dataCell.representedObject = person;
            dataCell.keyPath = @"firstName";
        });

        it(@"should have a value equal to the value of the property it represents", ^{
            [[dataCell.value should] equal:person.firstName];
        });
    });
});

SPEC_END