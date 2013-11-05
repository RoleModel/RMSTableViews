//
//  RMSTextEntryCell.m

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTextEntryCell.h"

@interface RMSTextEntryCell ()

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) RMSTextFieldObserver *textFieldObserver;

@end


@implementation RMSTextEntryCell

+ (NSString *)nibName {
    return @"RMSTextEntryCell";
}

+ (instancetype)cell {
    RMSTextEntryCell *cell = [super cell];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFieldObserver = [[RMSTextFieldObserver alloc] initWithEndEditingBlock:^(NSString *text){
        cell.value = text;
    }];

    cell.textField.delegate = cell.textFieldObserver;
    cell.textField.keyboardType = UIKeyboardTypeDefault;

    return cell;
}

- (UILabel *)primaryLabel {
    return self.label;
}

- (void)synchronizeView {
    self.textField.text = self.value;
}

- (void)setNextTextEntryCell:(RMSTextEntryCell *)nextTextEntryCell withBlock:(void (^)())block {
    [self.textFieldObserver setNextTextField:nextTextEntryCell.textField withBlock:block];
}

- (NSNumber *)secureTextEntry {
    return @(self.textField.secureTextEntry);
}

- (void)setSecureTextEntry:(NSNumber *)secureTextEntry {
    self.textField.secureTextEntry = [secureTextEntry boolValue];
}

@end
