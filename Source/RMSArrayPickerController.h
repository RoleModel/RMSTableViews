//
//  RMSArrayPickerController.h
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

#import <UIKit/UIKit.h>

typedef void (^RMSObjectSelectedBlock)(id object);

@class RMSArrayPickerController;

@protocol RMSArrayPickerControllerDelegate <NSObject>

@optional

- (void)arrayPickerController:(RMSArrayPickerController *)arrayPickerController selectedObject:(id)selectedObject;

- (void)arrayPickerController:(RMSArrayPickerController *)arrayPickerController willReturnCell:(UITableViewCell *)cell forObject:(id)object;

- (NSArray *)choicesForArrayPickerController:(RMSArrayPickerController *)arrayPickerController;

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
