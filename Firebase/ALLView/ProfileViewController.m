//
//  ProfileViewController.m
//  Firebase
//
//  Created by Nishant on 28/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fn_SetupRevelView];
    self.ref = [[FIRDatabase database] reference];
    
    NSString *uid = [GeneralSetting sharedInstance].user_FIR.uid;
    NSString *email = [GeneralSetting sharedInstance].user_FIR.email;
    NSURL *photoURL = [GeneralSetting sharedInstance].user_FIR.photoURL;
    
    NSLog(@"photoURL===%@",photoURL);
    _lbl_userEmai.text = email;
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
-(IBAction)click_camera:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Picture"
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* Gallery = [UIAlertAction
                         actionWithTitle:@"Gallery"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSLog(@"Resolving UIAlert Action for tapping OK Button");
                             picker = [[UIImagePickerController alloc] init];
                             picker.delegate = self;
                             picker.allowsEditing = YES;
                             picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                             
                             [self presentViewController:picker animated:YES completion:nil];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* Camera = [UIAlertAction
                         actionWithTitle:@"Camera"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             NSLog(@"Resolving UIAlert Action for tapping OK Button");
                             picker = [[UIImagePickerController alloc] init];
                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                             picker.delegate = self;
                             [self presentViewController:picker animated:YES completion:nil];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:Gallery];
    [alert addAction:Camera];
    [alert addAction:cancel];
    

    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
   
    [picker dismissViewControllerAnimated:YES completion:nil];
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
