//
//  MyPostViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPostViewController : UIViewController<SWRevealViewControllerDelegate>
{
    NSMutableArray *ary_allPost;
}
@property (nonatomic) IBOutlet UIButton* revealButtonItem;
@property(strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UITableView *tbl_allPost;
@end
