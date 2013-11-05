//
//  UIAlertView+RMS.m
//
//  Created by Tony Ingraldi on 7/8/13.
//

#import "UIAlertView+RMS.h"

@implementation UIAlertView (RMS)

+ (void)showAlertWithMessage:(NSString *)alertMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:alertMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil] ;
    
    [alert show];
}

@end
