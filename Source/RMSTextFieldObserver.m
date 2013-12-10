//
//  RMSTextFieldObserver.m
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

#import "RMSTextFieldObserver.h"

NSString * const RMSResponderTraversalStatusChanged = @"RMSResponderTraversalStatusChanged";
NSString * const RMSResponderTraversalEnabledUserInfoKey = @"RMSResponderTraversalEnabledUserInfoKey";


@interface RMSTextFieldObserver ()

@property (nonatomic, strong) RMSTextFieldObserverBlock endEditingBlock;
@property (nonatomic, strong) void (^nextTextFieldBlock)();
@property (nonatomic) BOOL shouldSetNextResponder;

@end

@implementation RMSTextFieldObserver

- (id)initWithEndEditingBlock:(RMSTextFieldObserverBlock)endEditingBlock {
    self = [super init];
    if (self != nil) {
        _endEditingBlock = endEditingBlock;
        _shouldSetNextResponder = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleResponderTraversalStatusChanged:)
                                                     name:RMSResponderTraversalStatusChanged
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleResponderTraversalStatusChanged:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    self.shouldSetNextResponder = [userInfo[RMSResponderTraversalEnabledUserInfoKey] boolValue];
}

- (void)setNextTextField:(UITextField *)nextTextField withBlock:(void (^)())block {
    self.nextTextField = nextTextField;
    self.nextTextFieldBlock = block;
}

- (void)resignTextField:(UITextField *)textField {
    [textField resignFirstResponder];

    if (self.shouldSetNextResponder && self.nextTextField != nil) {
        [self.nextTextField becomeFirstResponder];
        if (self.nextTextFieldBlock != NULL) {
            self.nextTextFieldBlock();
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.endEditingBlock != NULL) {
        self.endEditingBlock(textField.text);
    }
    [self resignTextField:textField];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignTextField:textField];
    return YES;
}
@end
