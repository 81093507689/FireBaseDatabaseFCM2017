//
//  HomesalesAPIManager.m
//  PropCalc
//
//  Created by Neena on 12/10/16.
//  Copyright © 2016 Rohit Kumar Modi. All rights reserved.
//

#import "NetworkManager.h"
#import "AppDelegate.h"
#import "Reachability.h"

@implementation NetworkManager

+(void)alert:(NSString *)getmessage title:(NSString *)getTitle
{
    AppDelegate * appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:getTitle message:getmessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [appDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
+(void) postNotification:(NSDictionary*)parameters getUrl:(NSString *)URL success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    AppDelegate * appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        
         [self alert:@"Check internet " title:@""];
        return;
    }
    
    
    
    
    [MBProgressHUD hideHUDForView:appDelegate.window animated:YES];
    
    [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
 
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"key=AIzaSyBmfBvv4CYtBxdYAIRp2KBG0NoS8dOqgy4" forHTTPHeaderField:@"Authorization"];
    
    manager.responseSerializer = [AFJSONResponseSerializer
                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

   
    
   
    
  
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:appDelegate.window animated:YES];
        success(responseObject);
        
        ////NSLog(@"success!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [MBProgressHUD hideHUDForView:appDelegate.window animated:YES];
     // NSLog(@"error: %@", error.description);
       NSLog(@"%@",[error localizedDescription]);
        // [self alert:@"" title:@""];
    }];
}


@end

