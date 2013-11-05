//
//  RMSFormSection.h
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewSection.h"

/*!
 \brief Represents a section of a UITableView managed by a RMSFormViewController.

 The RMSFormSection class represents a section of a UITableView managed by a RMSFormViewController.
 It manages the rows and textual headers and footers for the section.
 */
@interface RMSFormSection : RMSTableViewSection

/*!
 An array of RMSFormCell objects
 */
@property (nonatomic, strong) NSArray *rows;

- (id)initWithRows:(NSArray *)rows;
- (NSInteger)indexOfCell:(UITableViewCell *)cell;

@end
