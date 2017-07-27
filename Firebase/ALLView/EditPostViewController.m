//
//  EditPostViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "EditPostViewController.h"

@interface EditPostViewController ()

@end

@implementation EditPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.ref = [[FIRDatabase database] reference];
    
    _txt_dec.text = [self.getDic valueForKey:@"body"];
    _txt_title.text = [self.getDic valueForKey:@"title"];
    NSString *postkey = [self.getDic valueForKey:@"key"];
    
    FIRDatabaseQuery *AllPost = [[self.ref child:@"posts"] child:postkey];
    
    
    [AllPost observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
      
        if (snapshot.value == [NSNull null]) {
            NSLog(@"No messages");
            
        } else {
            //[self.arrayOfBookingDetail removeAllObjects];
            //self.arrayOfBookingDetail = (snapshot.children);
            //NSString *firstMessage = [self.arrayOfBookingDetail objectAtIndex:0];
            //NSLog(@"First message is: %@", firstMessage);
            NSDictionary *allUsersData = (NSDictionary*)snapshot.value;
            NSLog(@"%@",allUsersData);
            //ary_allPost = (NSArray *)snapshot.value;
            //NSLog(@"%@",getAll);
            //[_tbl_allPost reloadData];
            for (NSString *key in allUsersData.allKeys) {
                 NSLog(@"@key is %@, data is %@",key,allUsersData[key]);
               
                
                    
            }
            
            
        }
        
        
    }];
    

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click_update:(id)sender
{
    [self writeNewPost:[GeneralSetting sharedInstance].user_FIR.uid
              username:[GeneralSetting sharedInstance].user_FIR.email
                 title:_txt_title.text
                  body:_txt_dec.text];
}
- (void)writeNewPost:(NSString *)userID username:(NSString *)username title:(NSString *)title body:(NSString *)body {
    // Create new post at /user-posts/$userid/$postid and at
    // /posts/$postid simultaneously
    // [START write_fan_out]
    NSString *key = [self.getDic valueForKey:@"key"];
    NSDictionary *post = @{@"uid": userID,
                           @"author": username,
                           @"title": title,
                           @"body": body,
                           @"key":key};
    
    
    /*
     [[ref
     child:@"user1"]
     updateChildValues:dictionary];
     
     [[ref
     child:@"user2"]
     updateChildValues:dictionary];
     */
    
    NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:key]: post};
    // NSDictionary *childUpdates = @{[@"/posts/" stringByAppendingString:post]: post};
    // [[_ref child:@"posts"]  updateChildValues:childUpdates];
    [_ref updateChildValues:childUpdates];
   
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)click_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
