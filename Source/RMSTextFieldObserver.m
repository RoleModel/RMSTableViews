//
//  RMSTextFieldObserver.m
//
//  Created by Tony Ingraldi on 7/15/13.
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
