//
//  ListViewController.h
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
{
    NSMutableArray *ary_allPost;
}
@property(strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) IBOutlet UITableView *tbl_allPost;
@end
