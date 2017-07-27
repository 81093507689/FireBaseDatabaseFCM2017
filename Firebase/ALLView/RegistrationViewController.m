//
//  RegistrationViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _ref = [[FIRDatabase database] reference];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click_submit:(id)sender
{
    [[FIRAuth auth] createUserWithEmail:_txt_email.text password:_txt_pass.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if(error)
        {
            [GeneralSetting alert:error.localizedDescription title:@"Message"];
        }else
        {
            
            
                FIRUserProfileChangeRequest *changeRequest =
                [[FIRAuth auth].currentUser profileChangeRequest];
                changeRequest.displayName = _txt_username.text;
                [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                 
                        if (error) {
                            
                            return;
                        }
                        // [START basic_write]
                        [[[_ref child:@"users"] child:user.uid]
                         setValue:@{@"username": _txt_username.text,@"fName": @"fname",@"lName": @"lName",@"devicetoken":[GeneralSetting sharedInstance].token_number}];
                    
                    
                }];
            
            
            
            
            
            
            
            
           
           /* NSDictionary *post = @{@"fName": @"fname",
                                   @"lName": @"lname",
                                   @"email": _txt_email.text,
                                   @"uid":user.uid};
            
            
            
            NSDictionary *childUpdates = @{[@"/AllUser/" stringByAppendingString:user.uid]: post};
        
            [_ref updateChildValues:childUpdates];
            */
            
            [GeneralSetting sharedInstance].user_FIR = user;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * ViewCon = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
            [self.navigationController pushViewController:ViewCon animated:YES];

            
        }
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
