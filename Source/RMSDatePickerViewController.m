//
//  RMSDatePickerViewController.m
//
//  Created by Tony Ingraldi on 7/15/13.
//

#import "RMSDatePickerViewController.h"

@interface RMSDatePickerViewController ()

@property (nonatomic, strong) IBOutlet UIDatePicker *picker;

@end

@implementation RMSDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.picker.datePickerMode = UIDatePickerModeDate;
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.date != nil) {
        self.picker.date = self.date;
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.completionBlock != NULL) {
        self.completionBlock(self.picker.date);
    }
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
