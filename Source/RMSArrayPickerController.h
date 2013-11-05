//
//  RMSArrayPickerController.h
//
//  Created by Tony Ingraldi on 5/30/09.
//

#import <UIKit/UIKit.h>

typedef void (^RMSObjectSelectedBlock)(id object);

@class RMSArrayPickerController;

@protocol RMSArrayPickerControllerDelegate <NSObject>

@optional

- (void)arrayPickerController:(RMSArrayPickerController *)arrayPickerController selectedObject:(id)selectedObject;

- (void)arrayPickerController:(RMSArrayPickerController *)arrayPickerController willReturnCell:(UITableViewCell *)cell forObject:(id)object;

@end

@interface RMSArrayPickerController : UITableViewController

- (id)initWithBackgroundColor:(UIColor *)color;
- (id)initWithBackgroundImageNamed:(NSString *)imageName;

@property (nonatomic, strong) RMSObjectSelectedBlock objectSelectedBlock;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) id selectedObject;
@property (nonatomic, weak) id<RMSArrayPickerControllerDelegate> delegate;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) BOOL dismissesOnSelection;

@end
