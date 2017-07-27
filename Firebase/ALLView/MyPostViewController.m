//
//  MyPostViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "MyPostViewController.h"
#import "PostTableViewCell.h"
#import "EditPostViewController.h"

@interface MyPostViewController ()

@end

@implementation MyPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fn_SetupRevelView];
    
    
    self.tbl_allPost.rowHeight = UITableViewAutomaticDimension;
    self.tbl_allPost.estimatedRowHeight = 44;
    self.ref = [[FIRDatabase database] reference];
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    FIRDatabaseQuery *AllPost = [[self.ref child:@"posts"] queryLimitedToFirst:100];
    [AllPost queryStartingAtValue:@"test@abc.com" childKey:@"author"];
    
    [AllPost observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        ary_allPost = [[NSMutableArray alloc] init];
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
                // NSLog(@"@key is %@, data is %@",key,allUsersData[key]);
                NSDictionary *getDic = allUsersData[key];
                NSString *getEmail = [getDic valueForKey:@"author"];
                if([getEmail isEqualToString:[GeneralSetting sharedInstance].user_FIR.email])
                [ary_allPost addObject:getDic];
            }
            
            
        }
        [_tbl_allPost reloadData];
        
    }];

}


#pragma mark - UITableViewDataSource
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // NSLog(@"---- %lu ",(unsigned long)ary_allPost.count);
    return ary_allPost.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    PostTableViewCell *cell = (PostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PostTableViewCell"];
    NSDictionary *getvalue = [ary_allPost objectAtIndex:indexPath.row];
    //NSLog(@"------%@",getvalue);
    cell.lbl_des.text =[getvalue valueForKey:@"body"];
    cell.lbl_email.text = [getvalue valueForKey:@"author"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewAutomaticDimension;
    
}- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditPostViewController * ViewCon = [storyboard instantiateViewControllerWithIdentifier:@"EditPostViewController"];
    ViewCon.getDic = [ary_allPost objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ViewCon animated:YES];
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
