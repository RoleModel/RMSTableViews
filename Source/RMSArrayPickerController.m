//
//  RMSArrayPickerController.m
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

#import "RMSArrayPickerController.h"

@implementation RMSArrayPickerController

- (id)init {
	return [self initWithBackgroundColor:nil];
}

- (id)initWithBackgroundColor:(UIColor *)color {
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self) {
		_backgroundColor = color;
	}
	return self;
}

- (id)initWithBackgroundImageNamed:(NSString *)imageName {
	self = [self initWithBackgroundColor:[UIColor clearColor]];
	if (self) {
		if (imageName != nil) {
			UIImage *image = [UIImage imageNamed:imageName];
			UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
			[[self tableView] setBackgroundView:imageView];
		}
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.backgroundColor != nil) {
        self.tableView.backgroundView = nil;
        self.tableView.backgroundColor = self.backgroundColor;
	}

    if ([self.delegate respondsToSelector:@selector(choicesForArrayPickerController:)]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *choices = [self.delegate choicesForArrayPickerController:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.choices = choices;
                [self.tableView reloadData];
            });
        });
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.choices count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Set up the cell...
	NSUInteger row = [indexPath row];
	id aChoice = [self.choices objectAtIndex:row];
	NSString *label = [aChoice description];
	[[cell textLabel] setText:label];

	if (self.selectedObject != nil && [aChoice isEqual:[self selectedObject]]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}

	if ([self.delegate respondsToSelector:@selector(arrayPickerController:willReturnCell:forObject:)]) {
		[self.delegate arrayPickerController:self
                              willReturnCell:cell
                                   forObject:aChoice];
	}

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger indexOfCurrentSelection = [self.choices indexOfObject:[self selectedObject]];
	NSIndexPath *indexPathForSelectedObject = [NSIndexPath indexPathForRow:indexOfCurrentSelection
																 inSection:0];

	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPathForSelectedObject];
	[cell setAccessoryType:UITableViewCellAccessoryNone];

	cell = [tableView cellForRowAtIndexPath:indexPath];
	[cell setAccessoryType:UITableViewCellAccessoryCheckmark];

	NSUInteger row = [indexPath row];
	[self setSelectedObject:[self.choices objectAtIndex:row]];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.delegate respondsToSelector:@selector(arrayPickerController:selectedObject:)]) {
        [self.delegate arrayPickerController:self selectedObject:self.selectedObject];
    }

    if (self.objectSelectedBlock != NULL) {
        self.objectSelectedBlock(self.selectedObject);
    }

    if (self.dismissesOnSelection) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

