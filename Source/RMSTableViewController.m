//
//  RMSTableViewController.m
//
//  Created by Tony Ingraldi on 11/1/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSTableViewController.h"
#import "RMSTableViewCell.h"
#import "RMSTableViewSection.h"

@interface RMSTableViewController ()

@property (nonatomic, strong, readwrite) NSArray *sections;

@end


@implementation RMSTableViewController

- (NSArray *)generateSections {
    return @[];
}

- (void)sectionGenerationDidComplete {

}

- (NSArray *)sections {
    if (_sections == nil) {
        _sections = [self generateSections];
        [self sectionGenerationDidComplete];
    }

    return _sections;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(respondToSelection)]) {
        [cell respondToSelection];
    }
}

#pragma mark UITableViewDatasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sections[indexPath.section] cellForIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section] rowCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex {
    RMSTableViewSection *section = self.sections[sectionIndex];
    return section.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex {
    RMSTableViewSection *section = self.sections[sectionIndex];
    return section.footerTitle;
}

@end
