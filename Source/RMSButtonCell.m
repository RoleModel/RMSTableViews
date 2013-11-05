//
//  RMSButtonCell.m

//
//  Created by Tony Ingraldi on 10/26/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
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
