//
//  RMSTargetActionCellSpec.m
//  Table View Demo
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