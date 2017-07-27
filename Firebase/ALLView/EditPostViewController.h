//
//  EditPostViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPostViewController : UIViewController
@property (nonatomic,retain)NSDictionary *getDic;
@property(strong, nonatomic) FIRDatabaseReference *ref;

@property (weak, nonatomic) IBOutlet UITextField *txt_title;
@property (weak, nonatomic) IBOutlet UITextView *txt_dec;

@end
