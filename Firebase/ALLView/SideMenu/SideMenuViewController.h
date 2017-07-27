//
//  SideMenuViewController.h
//  IHRM
//
//  Created by Nishant on 16/06/17.
//  Copyright © 2017 Chandni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController
{
    NSArray *ary_SideMenu;
     NSArray *ary_images;
    NSArray *ary_images_wt;
}

@property (nonatomic,retain) IBOutlet UITableView *tbl_Sidemenu;
@end
