//
//  RMSFormViewController.m
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

#import "RMSFormViewController.h"
#import "RMSFormSection.h"
#import "RMSTextEntryCell.h"

static NSString * RMSFileExtensionPropertyList = @"plist";
static NSString * RMSFileExtensionJSON = @"json";

NSString * const RMSFormKeyClassName = @"className";

NSString * const RMSFormKeySectionRows = @"rows";

NSString * const RMSFormKeyProperties = @"properties";
NSString * const RMSFormKeyBindVariable = @"bindVariable";
NSString * const RMSFormKeyEnabled = @"enabled";


@interface RMSFormViewController ()

@property (nonatomic, strong) NSArray *descriptor;
@property (nonatomic, strong) NSDictionary *objectDictionary;

@end


@implementation RMSFormViewController

- (id)initWithStyle:(UITableViewStyle)style descriptor:(NSArray *)descriptor {
    self = [super initWithStyle:style];
    if (self) {
        _descriptor = descriptor;
    }

    return self;
}

- (id)initWithStyle:(UITableViewStyle)style descriptorNamed:(NSString *)descriptorName {
    descriptorName = descriptorName ? descriptorName : [[self class] description];
    NSString *descriptorExtension = [descriptorName pathExtension];
    NSString *descriptorRoot = [descriptorName stringByDeletingPathExtension];

    descriptorExtension = [descriptorExtension length] > 0 ? descriptorExtension : RMSFileExtensionPropertyList;

    NSString *descriptorPath = [[NSBundle mainBundle] pathForResource:descriptorRoot ofType:descriptorExtension];
    NSData *descriptorData = [NSData dataWithContentsOfFile:descriptorPath];
    RMSFormDescriptorType descriptorType = [descriptorExtension isEqualToString:RMSFileExtensionPropertyList] ? RMSFormDescriptorTypePlist : RMSFormDescriptorTypeJSON;

    return [self initWithStyle:style rawDescriptor:descriptorData type:descriptorType];
}

- (id)initWithStyle:(UITableViewStyle)style rawDescriptor:(NSData *)rawDescriptor type:(RMSFormDescriptorType)descriptorType {
    NSArray *descriptor = nil;
    NSError *error = nil;
    if (descriptorType == RMSFormDescriptorTypePlist) {
        descriptor = [NSPropertyListSerialization propertyListWithData:rawDescriptor
                                                               options:NSPropertyListImmutable
                                                                format:NULL
                                                                 error:&error];
    } else if (descriptorType == RMSFormDescriptorTypeJSON) {
        descriptor = [NSJSONSerialization JSONObjectWithData:rawDescriptor
                                                     options:0
                                                       error:&error];
    } else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Illegal extension specified for descriptor file. (Must be either plist or json)"
                                     userInfo:nil];
    }

    if (error) {
        DLog(@"Failed to decode descriptor: %@", [error localizedDescription]);
    }
    
    return [self initWithStyle:style descriptor:descriptor];

}

- (NSDictionary *)objectSubstitionDictionary {
    return @{};
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(hideKeyboard:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)hideKeyboard:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:RMSResponderTraversalStatusChanged
                                                        object:self
                                                      userInfo:@{RMSResponderTraversalEnabledUserInfoKey : @(NO)}];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:RMSResponderTraversalStatusChanged
                                                        object:self
                                                      userInfo:@{RMSResponderTraversalEnabledUserInfoKey : @(YES)}];
}

- (void)setNextResponders {
    RMSTextEntryCell *previousTextEntryCell = nil;

    for (RMSFormSection *section in self.sections) {
        for (RMSFormCell *formCell in section.rows) {
            if ([formCell isKindOfClass:[RMSTextEntryCell class]]) {
                RMSTextEntryCell *currentTextEntryCell = (RMSTextEntryCell *)formCell;
                if (previousTextEntryCell) {
                    NSInteger sectionIndex = [self.sections indexOfObject:section];
                    NSInteger rowIndex = [section indexOfCell:formCell];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];

                    [previousTextEntryCell setNextTextEntryCell:currentTextEntryCell withBlock:^{
                        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                        if (cell) {
                            [self.tableView scrollToRowAtIndexPath:indexPath
                                                  atScrollPosition:UITableViewScrollPositionBottom
                                                          animated:YES];
                        }
                    }];
                }
                previousTextEntryCell = currentTextEntryCell;
            }
        }
    }
}

#pragma mark RMSFormCell delegate methods

- (void)formCell:(RMSFormCell *)formCell pushViewController:(UIViewController *)viewController {
    [self hideKeyboard:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)formCell:(RMSFormCell *)formCell presentController:(UIViewController *)viewController {
    [self hideKeyboard:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark

- (NSDictionary *)objectDictionary {
    if (_objectDictionary == nil) {
        NSMutableDictionary *objectDictionary = [NSMutableDictionary dictionary];
        objectDictionary[@":self"] = self;
        [objectDictionary addEntriesFromDictionary:[self objectSubstitionDictionary]];
        _objectDictionary = [NSDictionary dictionaryWithDictionary:objectDictionary];
    }

    return _objectDictionary;
}

- (id)objectForValue:(id)value {
    id object = nil;
    if ([value isKindOfClass:[NSString class]]) {
        NSRange colonRange = [value rangeOfString:@":"];
        if (colonRange.location == 0) {
            object = self.objectDictionary[value];
        } else {
            object = value;
        }

        if (!object) {
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:[@"No value found for " stringByAppendingString:value]
                                         userInfo:nil];
        }
    } else {
        object = value;
    }

    return object;
}

- (BOOL)itemIsEnabled:(NSDictionary *)itemDictionary {
    BOOL enabled = YES;
    NSString *enabledValue = itemDictionary[RMSFormKeyEnabled];
    if (enabledValue) {
        enabled = [[self objectForValue:enabledValue] boolValue];
    };

    return enabled;
}

- (void)setProperties:(id)object withRawDictionary:(NSDictionary *)rawDictionary {
    NSDictionary *properties = rawDictionary[RMSFormKeyProperties];
    for (NSString *keyPath in [properties allKeys]) {
        id value = [self objectForValue:properties[keyPath]];
        [object setValue:value forKeyPath:keyPath];
    }
}

- (RMSFormCell *)cellFromDictionary:(NSDictionary *)rawDictionary {
    id formCellClass = NSClassFromString(rawDictionary[RMSFormKeyClassName]);
    RMSFormCell *formCell = [formCellClass cell];

    [self setProperties:formCell withRawDictionary:rawDictionary];

    formCell.delegate = self;
    [formCell synchronizeView];

    return formCell;
}

- (void)bindObject:(id)object dictionary:(NSDictionary *)objectDescription {
    // (conditionally) bind to instance variable
    NSString *bindVariable = objectDescription[RMSFormKeyBindVariable];
    if (bindVariable) {
        [self setValue:object forKey:bindVariable];
    }
}

- (NSArray *)generateSections {
    NSMutableArray *sections = [NSMutableArray array];

    for (NSDictionary *rawSection in self.descriptor) {
        if ([self itemIsEnabled:rawSection]) {
            NSMutableArray *rows = [NSMutableArray array];
            NSArray *rawCells = rawSection[RMSFormKeySectionRows];

            for (NSDictionary *rawCell in rawCells) {
                if ([self itemIsEnabled:rawCell]) {
                    RMSFormCell *formCell = [self cellFromDictionary:rawCell];

                    [self bindObject:formCell dictionary:rawCell];

                    [rows addObject:formCell];
                }
            }

            id sectionClass = NSClassFromString(rawSection[RMSFormKeyClassName]);
            sectionClass = sectionClass ? sectionClass : [RMSFormSection class];
            RMSFormSection *section = [[sectionClass alloc] initWithRows:rows];
            [self setProperties:section withRawDictionary:rawSection];

            [self bindObject:section dictionary:rawSection];
            
            [sections addObject:section];
        }
    }
    
    return sections;
}

- (void)sectionGenerationDidComplete {
    [super sectionGenerationDidComplete];
    
    [self setNextResponders];
}

@end
