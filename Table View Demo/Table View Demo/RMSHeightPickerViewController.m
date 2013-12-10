//
//  RMSHeightPickerViewController.m
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

#import "RMSHeightPickerViewController.h"


@interface RMSHeightPickerViewController ()

@property (nonatomic, strong) NSArray *feetChoices;
@property (nonatomic, strong) NSArray *inchChoices;
@property (nonatomic, strong) IBOutlet UIPickerView *picker;

@end

@implementation RMSHeightPickerViewController

- (void)awakeFromNib {
    DLog(@"");
    self.height = @(70);

    self.feetChoices = @[@4, @5, @6, @7];
    self.inchChoices = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    if (self.height) {
        NSInteger height = [self.height integerValue];
        NSInteger feetSelection = (height / 12) - 4;
        NSInteger inchSelection = (height % 12);
        if ((feetSelection >= 0) && (feetSelection < [self.feetChoices count])) {
            [self.picker selectRow:feetSelection inComponent:0 animated:NO];
            [self.picker selectRow:inchSelection inComponent:1 animated:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.completionBlock != NULL) {
        self.completionBlock(self.height);
    }
    [super viewWillDisappear:animated];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = nil;
    if (component == 0) {
        title = [NSString stringWithFormat:@"%@ feet", self.feetChoices[row]];
    } else {
        NSString *suffix = @"es";
        if (row == 1) {
            suffix = @"";
        }
        title = [NSString stringWithFormat:@"%@ inch%@", self.inchChoices[row], suffix];
    }
    
    return title;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count = 0;
    
    if (component == 0) {
        count = [self.feetChoices count];
    } else {
        count = [self.inchChoices count];
    }
    
    return count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger selectedFeetIndex = [self.picker selectedRowInComponent:0];
    NSInteger selectedInchIndex = [self.picker selectedRowInComponent:1];
    NSInteger feet = [self.feetChoices[selectedFeetIndex] integerValue];
    NSInteger inches = [self.inchChoices[selectedInchIndex] integerValue];
    self.height = [NSNumber numberWithInteger:feet * 12 + inches];
}


@end
