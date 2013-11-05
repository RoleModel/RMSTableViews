//
//  RMSWordViewController.m
//  Tabulator
//
//  Created by Tony Ingraldi on 11/2/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSWordViewController.h"
#import "RMSDynamicSection.h"
#import "RMSWordCell.h"

static NSString *CellIdentifier = @"Cell";


@interface RMSWordViewController ()

@property (nonatomic, strong) NSArray *words;

@end


@implementation RMSWordViewController

- (void)viewDidLoad {
    self.title = @"Words";
    [self.tableView registerClass:[RMSWordCell class] forCellReuseIdentifier:CellIdentifier];
}

- (NSArray *)words {
    if (_words == nil) {
        NSSet *wordSet = [NSSet setWithArray:[@"We the people of the United States in order to form a more perfect union establish justice insure domestic tranquility provide for the common defense promote the general welfare and secure the blessings of liberty to ourselves and our posterity do ordain and establish this Constitution for the United States of America" componentsSeparatedByString:@" "]];
        _words = [[wordSet allObjects] sortedArrayUsingComparator:^NSComparisonResult(id string1, id string2) {
            return [string1 localizedCaseInsensitiveCompare:string2];
        }];
    }

    return _words;
}


- (NSArray *)generateSections {
    NSMutableArray *sections = [NSMutableArray array];
    for (NSString *letter in [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@", letter];
        NSArray *filteredLetters = [self.words filteredArrayUsingPredicate:predicate];
        if ([filteredLetters count]) {
            RMSDynamicSection *section = [[RMSDynamicSection alloc] initWithTableView:self.tableView cellIdentifier:CellIdentifier];
            section.representedObjects = filteredLetters;
            section.headerTitle = letter;
            [sections addObject:section];
        }
    }

    return sections;
}

@end
