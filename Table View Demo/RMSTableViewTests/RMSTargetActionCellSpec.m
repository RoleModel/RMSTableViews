//
//  RMSTargetActionCellSpec.m
//  Table View Demo
//
//  Created by Tony Ingraldi on 11/7/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTargetActionCell.h"
#import "Kiwi.h"

@interface Actor : NSObject

@property (nonatomic) BOOL state;

- (id)initWithState:(BOOL)state;
- (void)toggleState;

@end

@implementation Actor

- (id)initWithState:(BOOL)state {
    self = [super init];
    if (self) {
        _state = state;
    }

    return self;
}

- (void)toggleState {
    self.state = !self.state;
}

@end


SPEC_BEGIN(RMSTargetActionCellSpec)

describe(@"RMSTargetActionCellSpec", ^{

    context(@"when triggered", ^{
        __block RMSTargetActionCell *targetActionCell = nil;
        __block Actor *actor = nil;
        BOOL initialState = YES;

        beforeAll(^{
            actor = [[Actor alloc] initWithState:initialState];

            targetActionCell = [RMSTargetActionCell cell];
            targetActionCell.target = actor;
            targetActionCell.selectorString = @"toggleState";

            [targetActionCell respondToSelection];
        });

        it(@"should send the action message to it's target", ^{
            [[theValue(actor.state) should] equal:theValue(!initialState)];
        });
    });
});

SPEC_END