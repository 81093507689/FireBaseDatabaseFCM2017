//
//  SideMenuViewController.m
//  IHRM
//
//  Created by Nishant on 16/06/17.
//  Copyright © 2017 Chandni. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "HomeViewController.h"
#import "MyPostViewController.h"


@interface SideMenuViewController ()

@end

@implementation SideMenuViewController
@synthesize tbl_Sidemenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        ary_SideMenu = [[NSArray alloc] initWithObjects:@"homeimage",@"New Post",@"My Post",@"Membership Directory",@"My Profile",@"Communication",@"Updates",@"Gallery",@"Billing & Payment",@"Event",@"Help",@"Logout", nil];
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary_SideMenu.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SideMenuTableViewCell *cell = (SideMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SideMenuTableViewCell"];
    
        if(indexPath.row == 0)
    {
        cell.lbl_name.text = [GeneralSetting sharedInstance].user_FIR.email;
        
    }else
    {
     
    
    
        
        cell.lbl_name.text = [ary_SideMenu objectAtIndex:indexPath.row];
       
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
        
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0)
    {
        
        SWRevealViewController *revealController = self.revealViewController;
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
       
            
            if(indexPath.row == 1)// About Us
            {
                
                
                HomeViewController * ViewCon = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                [revealController pushFrontViewController:ViewCon animated:YES];
                
            }
        else if(indexPath.row == 2)// My post
        {
            
            
            MyPostViewController * ViewCon = [storyboard instantiateViewControllerWithIdentifier:@"MyPostViewController"];
            [revealController pushFrontViewController:ViewCon animated:YES];
            
        }
        

        
        
        
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row == 0)
   {
       return 200;
   }else
   {
       return 50;
   }
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
