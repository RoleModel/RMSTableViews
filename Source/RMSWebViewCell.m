//
//  RMSWebViewCell.m
//
//  Created by Tony Ingraldi on 10/29/13.
//  Copyright (c) 2013 RoleModel Software, Inc. All rights reserved.
//

#import "RMSWebViewCell.h"

@implementation RMSWebViewCell

+ (instancetype)cell {
    RMSWebViewCell *cell = [super cell];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)respondToSelection {
    UIWebView *webView = [[UIWebView alloc] init];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
    webView.scalesPageToFit = YES;
    [webView loadRequest:request];
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view = webView;
    viewController.title = self.title;

    if ([self.delegate respondsToSelector:@selector(formCell:pushViewController:)]) {
        [self.delegate formCell:self pushViewController:viewController];
    }
}

@end
