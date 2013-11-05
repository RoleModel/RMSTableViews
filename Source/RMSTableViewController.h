//
//  RMSTableViewController.h
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMSTableViewController : UITableViewController

/*!
 \brief An array of RMSTableViewSection objects
 */
@property (nonatomic, strong, readonly) NSArray *sections;

/*!
 \brief Message sent to the receiver when the sections property is first accessed.
 */
- (NSArray *)generateSections;

/*!
 \brief Message sent to the receiver after the sections property has been initialized.
 */
- (void)sectionGenerationDidComplete;

@end
