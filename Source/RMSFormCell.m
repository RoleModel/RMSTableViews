//
//  RMSFormCell.m

//
//  Created by Tony Ingraldi on 10/28/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
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
