//
//  RMSFormCell.h

//
//  Created by Tony Ingraldi on 10/27/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMSTableViewCell.h"

@class RMSFormCell;


@protocol RMSFormCellDelegate <RMSTableViewCell>

@optional

/*!
 \brief An RMSFormCell sends this message to its delegate when it has created a 
  UIViewController that needs to be pushed onto the navigation stack.

 \b RMSFormViewController implements this delegate method. Subclasses of 
 \b RMSFormViewController can optionally override or extend this method to provide
 custom behavior.

 \param formCell The cell that is sending this message
 \param viewController The UIViewController to be pushed
 */
- (void)formCell:(RMSFormCell *)formCell pushViewController:(UIViewController *)viewController;

/*!
 \brief An RMSFormCell sends this message to its delegate when it has created a
 UIViewController that needs to be presented modally.

 \b RMSFormViewController implements this delegate method. Subclasses of
 \b RMSFormViewController can optionally override or extend this method to provide
 custom behavior.

 \param formCell The cell that is sending this message
 \param viewController The UIViewController to be presented
 */
- (void)formCell:(RMSFormCell *)formCell presentController:(UIViewController *)viewController;

@end


/*!
 \brief A subclass of UITableViewCell intended for use in table views managed by an \b RMSFormViewController

 \b RMSFormCell is the base class for all cells used in the table views managed by an \b RMSFormViewController.
 Several subclasses are provided to fulfill general usages. Extending RMSFormCell or one of its provided
 subclasses enables handling of application-specific cases, usually with a minimal amount of code.
 */
@interface RMSFormCell : UITableViewCell <RMSTableViewCell>

@property (nonatomic, weak) id<RMSFormCellDelegate> delegate;

/*!
 \brief A reference to the cell's primary label. This is typically the descriptive label displayed on the left
 side of the cell.
 */
@property (nonatomic, readonly) UILabel *primaryLabel;

/*!
 \brief A convenience property to access the text of the primaryLabel.
 */
@property (nonatomic) NSString *labelText;

/*!
 \brief The name of the NIB, if any, to be used to instantiate the cell.
 
 \return The name of the NIB defining the cell layout.
 */
+ (NSString *)nibName;

/*!
 \brief The style of the cell for cells that are not NIB-based.

 \return A UITableViewCellStyle (defaults to UITableViewStyleDefault)
 */
+ (UITableViewCellStyle)cellStyle;

/*!
 \brief Factor method used to instantiate form cells
 
 Subclasses may extend the behavior of cell.
 */
+ (instancetype)cell;

/*!
 \brief Synchronizes the view hierarchy of the receiver with it's internal state.

 This message is sent to RMSFormCells by an RMSFormViewController immediately after instantiation.
 RMSFormCell subclasses must first call super when extending this method.
 */
- (void)synchronizeView;

@end


