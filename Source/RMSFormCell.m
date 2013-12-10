//
//  RMSFormCell.m
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

#import "RMSFormCell.h"

@implementation RMSFormCell

+ (NSString *)nibName {
    return nil;
}

+ (UITableViewCellStyle)cellStyle {
    return UITableViewCellStyleDefault;
}

+ (instancetype)cell {
    NSString *nibName = [self nibName];
    UITableViewCellStyle cellStyle = [self cellStyle];

    RMSFormCell *cell = nil;
    if (nibName != nil) {
        UINib *cellNib = [UINib nibWithNibName:[self nibName] bundle:nil];

        NSArray *objects = [cellNib instantiateWithOwner:nil options:nil];
        cell = objects[0];
    } else {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:nil];
    }
    
    return cell;
}

- (UILabel *)primaryLabel {
    return self.textLabel;
}

- (NSString *)labelText {
    return self.primaryLabel.text;
}

- (void)setLabelText:(NSString *)labelText {
    self.primaryLabel.text = labelText;
}

- (void)synchronizeView {

}

- (void)respondToSelection {

}

@end
