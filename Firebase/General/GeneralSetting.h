//
//  GeneralSetting.h
//  Veneer
//
//  Created by Chandni on 06/01/17.
//  Copyright © 2017 Chandni. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface GeneralSetting : NSObject



+ (GeneralSetting*)sharedInstance;
+(void)alert:(NSString *)getmessage title:(NSString *)getTitle;

@property FIRUser *user_FIR;
@property (nonatomic,retain) NSString *token_number;
@end
