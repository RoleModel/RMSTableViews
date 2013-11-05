//
//  RMSArrayPickerController.m
//
//  Created by Tony Ingraldi on 5/30/09.
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

