//
//  RMSDataCell.m
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

#import "RMSDataCell.h"

static void * RMSDataCellObservingContext = &RMSDataCellObservingContext;


@interface RMSDataCell ()

@property (nonatomic) BOOL isObservingValue;

@end


@implementation RMSDataCell

- (void)startObservingValue {
    if (!self.isObservingValue && self.keyPath) {
        [self.representedObject addObserver:self
                                 forKeyPath:self.keyPath
                                    options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                                    context:RMSDataCellObservingContext];
        self.isObservingValue = YES;
    }
}

- (void)stopObservingValue {
    if (self.isObservingValue && self.keyPath) {
        [self.representedObject removeObserver:self
                                    forKeyPath:self.keyPath
                                       context:RMSDataCellObservingContext];
        self.isObservingValue = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == RMSDataCellObservingContext) {
        [self synchronizeView];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)awakeFromFormDescriptor {
    [super awakeFromFormDescriptor];
    self.isObservingValue = NO;

    [self startObservingValue];
}

- (void)dealloc {
    [self stopObservingValue];
}

- (void)setValue:(id)value {
    [self stopObservingValue];
    [self.representedObject setValue:value forKeyPath:self.keyPath];
    [self startObservingValue];
}

- (id)value {
    return [self.representedObject valueForKeyPath:self.keyPath];
}

@end
