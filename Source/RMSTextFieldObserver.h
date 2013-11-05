//
//  RMSTextFieldObserver.h
//
//  Created by Tony Ingraldi on 7/15/13.
//

#import <Foundation/Foundation.h>

extern NSString * const RMSResponderTraversalStatusChanged;
extern NSString * const RMSResponderTraversalEnabledUserInfoKey;


typedef void (^RMSTextFieldObserverBlock)(NSString *text);

@interface RMSTextFieldObserver : NSObject <UITextFieldDelegate>

- (id)initWithEndEditingBlock:(RMSTextFieldObserverBlock)endEditingBlock;

@property (nonatomic, strong) UITextField *nextTextField;

- (void)setNextTextField:(UITextField *)nextTextField withBlock:(void (^)())block;

@end
