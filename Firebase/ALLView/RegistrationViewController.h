//
//  RegistrationViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_username;
@property (strong, nonatomic) IBOutlet UITextField *txt_pass;
@property(strong, nonatomic) FIRDatabaseReference *ref;
@end
