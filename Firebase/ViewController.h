//
//  ViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;

@property (strong, nonatomic) IBOutlet UITextField *txt_email;

@property (strong, nonatomic) IBOutlet UITextField *txt_pass;
@end

