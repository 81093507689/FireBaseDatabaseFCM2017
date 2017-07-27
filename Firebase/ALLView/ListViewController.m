//
//  ListViewController.m
//  Firebase
//
//  Created by Nishant on 26/06/17.
//  Copyright © 2017 Systematix. All rights reserved.
//

#import "ListViewController.h"
#import "PostTableViewCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tbl_allPost.rowHeight = UITableViewAutomaticDimension;
    self.tbl_allPost.estimatedRowHeight = 44;
    self.ref = [[FIRDatabase database] reference];
    
    FIRDatabaseQuery *AllPost = [[self.ref child:@"posts"] queryLimitedToFirst:100];
    
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
                NSLog(@"@key is %@, data is %@",key,allUsersData[key]);
                NSDictionary *getDic = allUsersData[key];
                [ary_allPost addObject:getDic];
            }
            
            
        }
        [_tbl_allPost reloadData];
        
    }];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)click_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
