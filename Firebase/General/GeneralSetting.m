//
//  GeneralSetting.m
//  Veneer
//
//  Created by Chandni on 06/01/17.
//  Copyright © 2017 Chandni. All rights reserved.
//

#import "GeneralSetting.h"
#import "AppDelegate.h"

@implementation GeneralSetting 




+ (GeneralSetting*)sharedInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        //sharedObject = [[[self alloc] init] retain]; // if you're not using ARC
    });
    return sharedObject;
}
+(void)alert:(NSString *)getmessage title:(NSString *)getTitle
{
    AppDelegate * appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:getTitle message:getmessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [appDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
