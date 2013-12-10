//
//  RMSDatePickerCell.m
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

#import "RMSDatePickerCell.h"
#import "RMSDatePickerViewController.h"

@implementation RMSDatePickerCell

- (void)synchronizeView {
    [super synchronizeView];
    
    if (self.value != nil) {
        self.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:self.value
                                                                   dateStyle:NSDateFormatterMediumStyle
                                                                   timeStyle:NSDateFormatterNoStyle];
    } else {
        self.detailTextLabel.text = nil;
    }
}

- (void)respondToSelection {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"RMSDatePickerView" bundle:nil];
    RMSDatePickerViewController *pickerViewController = [storyboard instantiateInitialViewController];
    pickerViewController.title = self.labelText;
    pickerViewController.date = self.value;
    pickerViewController.completionBlock = ^(NSDate *date) {
        self.value = date;
    };

    if ([self.delegate respondsToSelector:@selector(formCell:pushViewController:)]) {
        [self.delegate formCell:self pushViewController:pickerViewController];
    }
}

@end
