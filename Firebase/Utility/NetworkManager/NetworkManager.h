//
//  HomesalesAPIManager.h
//  PropCalc
//
//  Created by Neena on 12/10/16.
//  Copyright © 2016 Rohit Kumar Modi. All rights reserved.
//

#import "AFNetworking.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface NetworkManager : NSObject

+(void)alert:(NSString *)getmessage title:(NSString *)getTitle;


+(void) postNotification:(NSDictionary*)parameters getUrl:(NSString *)URL success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
