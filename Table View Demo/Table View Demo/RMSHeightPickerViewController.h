//
//  RMSHeightPickerViewController.h
//
//  Created by Tony Ingraldi on 7/15/13.
//

#import <UIKit/UIKit.h>

typedef void (^RMSHeightPickerCompletionBlock)(NSNumber *height);

@interface RMSHeightPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) RMSHeightPickerCompletionBlock completionBlock;

@end
