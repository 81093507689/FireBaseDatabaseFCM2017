//
//  ProfileViewController.h
//  Firebase
//
//  Created by Nishant on 28/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<SWRevealViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
}
@property(strong, nonatomic) FIRDatabaseReference *ref;

@property (weak, nonatomic) IBOutlet UILabel *lbl_userEmai;

@property (weak, nonatomic) IBOutlet UIImageView  *img_userImage;

@property (nonatomic) IBOutlet UIButton* revealButtonItem;
@end
