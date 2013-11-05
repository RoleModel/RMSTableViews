//
//  RMSHeightPickerViewController.m
//
//  Created by Tony Ingraldi on 7/15/13.
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
