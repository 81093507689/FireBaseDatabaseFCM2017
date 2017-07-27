//
//  HomeViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self fn_SetupRevelView];
    self.ref = [[FIRDatabase database] reference];
    //NSString *getUeremail = [GeneralSetting sharedInstance].user_FIR.email;
    //_lbl_userEmai.text = getUeremail;
    // Do any additional setup after loading the view.
}
- (void)fn_SetupRevelView
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        revealViewController.delegate = self;
        
        [self.revealButtonItem addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        ///[self.revealButtonItem setTarget: self.revealViewController];
        //[self.revealButtonItem setAction: @selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        
        [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
        
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click_submit:(id)sender
{
    [self sendPush];
    /*
    [self writeNewPost:[GeneralSetting sharedInstance].user_FIR.uid
              username:[GeneralSetting sharedInstance].user_FIR.email
                 title:_txt_title.text
                  body:_txt_desc.text];
     */
    
}
- (void)writeNewPost:(NSString *)userID username:(NSString *)username title:(NSString *)title body:(NSString *)body {
    // Create new post at /user-posts/$userid/$postid and at
    // /posts/$postid simultaneously
    // [START write_fan_out]
    NSString *key = [[_ref child:@"posts"] childByAutoId].key;
    NSDictionary *post = @{@"uid": userID,
                           @"author": username,
                           @"title": title,
                           @"body": body,
                           @"key":key};
    
    
    
    NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: post};
   // NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:post]: post};
   // [[_ref child:@"posts"]  updateChildValues:childUpdates];
    [_ref updateChildValues:childUpdates];
    _txt_title.text = @"";
    _txt_desc.text = @"";
    
    [self sendPush];
    // send push to my self
    
    // [END write_fan_out]
}
-(void)sendPush
{
    
    
   
     NSDictionary *noti = @{@"body": @"Hello", @"title": @"This is test message"};
    
    NSDictionary *params = @{@"to": [GeneralSetting sharedInstance].token_number,@"notification":noti};
    NSLog(@"%@",params);
    
    
   
    
    [NetworkManager postNotification:params getUrl:@"https://fcm.googleapis.com/fcm/send" success:^(id response) {
         NSLog(@"%@",response);
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
