//
//  HomeViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<SWRevealViewControllerDelegate>
@property(strong, nonatomic) FIRDatabaseReference *ref;


@property (nonatomic) IBOutlet UIButton* revealButtonItem;

@property (weak, nonatomic) IBOutlet UILabel *lbl_userEmai;
@property (weak, nonatomic) IBOutlet UITextField *txt_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_desc;

@end
