//
//  ViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "ViewController.h"
@import Firebase;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewDidAppear:(BOOL)animated {
   
    _ref = [[FIRDatabase database] reference];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click_submit:(id)sender
{
   
    
    [[FIRAuth auth] signInWithEmail:self.txt_email.text
                           password:self.txt_pass.text
                         completion:^(FIRUser *user, NSError *error) {
                            
                                 if (error) {
                                     // NSLog(@"Error==%@",error.localizedDescription);
                                     
                                     
                                     [GeneralSetting alert:error.localizedDescription title:@"Message"];
                                     return;
                                 }
                             [GeneralSetting sharedInstance].user_FIR = user;
                             
                           
                             
                             
                             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             UIViewController * ViewCon = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                             [self.navigationController pushViewController:ViewCon animated:YES];
                             
                             
                             FIRUserProfileChangeRequest *changeRequest =
                             [[FIRAuth auth].currentUser profileChangeRequest];
                             changeRequest.displayName = @"change doken";
                             [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                                 
                                 if (error) {
                                     
                                     return;
                                 }
                                 // [START basic_write]
                                 [[[_ref child:@"users"] child:user.uid]
                                  setValue:@{@"devicetoken":[GeneralSetting sharedInstance].token_number}];
                                 
                                 
                             }];

                             
                             
                             
                                /* [[[_ref child:@"users"] child:user.uid]
                                  observeEventType:FIRDataEventTypeValue
                                  withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                      
                                      if (![snapshot exists]) {
                                          NSLog(@"DONE");
                                      } else {
                                           NSLog(@"Error");
                                      }
                                  }];
                             */
                            
                         }];
    
    
    //[[[[_ref child:@"users"] child:@"123"] child:@"username"] setValue:@"nishant"];
}


@end
