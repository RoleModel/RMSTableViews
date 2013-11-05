//
//  RMSDatePickerViewController.h
//
//  Created by Tony Ingraldi on 7/15/13.
//

#import <UIKit/UIKit.h>

typedef void (^RMSDatePickerCompletionBlock)(NSDate *date);

@interface RMSDatePickerViewController : UIViewController

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) RMSDatePickerCompletionBlock completionBlock;

@end
