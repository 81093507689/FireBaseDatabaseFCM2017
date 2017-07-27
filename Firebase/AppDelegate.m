//
//  AppDelegate.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;
@import FirebaseAuth;
#import "ViewController.h"


@import FirebaseCore;
@import FirebaseMessaging;
@import FirebaseInstanceID;
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()<UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    
    [FIRDatabase database].persistenceEnabled = YES;
    FIRDatabaseReference *scoresRef = [[FIRDatabase database] referenceWithPath:@"scores"];
    [scoresRef keepSynced:YES];
    [self fn_notification];
    //[scoresRef keepSynced:NO];
    
   // FIRDatabaseReference *scoresRef = [[FIRDatabase database] referenceWithPath:@"scores"];
    /*[[[scoresRef queryOrderedByValue] queryLimitedToLast:4]
     observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
         NSLog(@"The %@ dinosaur's score is %@", snapshot.key, snapshot.value);
     }];
    
    FIRDatabaseReference *presenceRef = [[FIRDatabase database] referenceWithPath:@"disconnectmessage"];
    // Write a string when this client loses connection
    [presenceRef onDisconnectSetValue:@"I disconnected!"];
    
    
    FIRDatabaseReference *connectedRef = [[FIRDatabase database] referenceWithPath:@".info/connected"];
    [connectedRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        if([snapshot.value boolValue]) {
            NSLog(@"connected");
        } else {
            NSLog(@"not connected");
        }
    }];
    */
    
    
    
     [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       if(user)
                       {
                           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                           UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"SWNavigation"];
                           //self.window.rootViewController = controller;
                           
                           
                          // [GeneralSetting sharedInstance].user_FIR = user;
                       }else
                       {
//                           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                           ViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//                           self.window.rootViewController = controller;
                       }
                   }];
    
    
   
    
   /* [[FIRAuth auth]
     createUserWithEmail:@"test@abc.com"
     password:@"123456"
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         if(error)
         {
         
         }else
         {
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"SWNavigation"];
             self.window.rootViewController = controller;
             
             
             [GeneralSetting sharedInstance].user_FIR = user;

         }
         // ...
     }];
    
   */
    // Override point for customization after application launch.
    
    
    
    
    
    
    
    return YES;
}

-(void)fn_notification
{
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}
- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    [GeneralSetting sharedInstance].token_number = fcmToken;
    
    // TODO: If necessary send token to application server.
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Notification===%@",userInfo);
    // NSDictionary *aget_dic = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    // NSString *alert_title = [aget_dic valueForKey:@"title"];
    // NSString *alert_body = [aget_dic valueForKey:@"body"];
    
    
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [FIRMessaging messaging].APNSToken = deviceToken;
    
    
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);
    if(fcmToken == nil)
    {
        [GeneralSetting sharedInstance].token_number = @"";
        [self fn_notification];
    }else
    {
        [GeneralSetting sharedInstance].token_number = fcmToken;
    }
    
    
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"APPLE TOKEN : %@",deviceTokenString);
  
    
}


@end
