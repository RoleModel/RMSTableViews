//
//  RMSButtonCell.m
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

#import "RMSButtonCell.h"

@interface RMSButtonCell ()

@property (nonatomic, strong) IBOutlet UILabel *label;

@end


@implementation RMSButtonCell

+ (NSString *)nibName {
    return @"RMSButtonCell";
}

+ (instancetype)cell {
    RMSButtonCell *cell = [super cell];

    cell.enabled = YES;

    return cell;
}

- (UILabel *)primaryLabel {
    return self.label;
}

- (void)setAlpha:(CGFloat)alpha forProperty:(NSString *)property {
    UIColor *color = [[self valueForKeyPath:property] colorWithAlphaComponent:alpha];
    [self setValue:color forKeyPath:property];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    self.selectionStyle = enabled ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    CGFloat colorAlpha = enabled ? 1.0 : 0.5;
    [self setAlpha:colorAlpha forProperty:@"backgroundColor"];
    [self setAlpha:colorAlpha forProperty:@"primaryLabel.textColor"];
}

- (void)respondToSelection {
    if (self.enabled) {
        [super respondToSelection];
    }
}

@end
