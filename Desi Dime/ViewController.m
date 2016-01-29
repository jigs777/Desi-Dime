//
//  ViewController.m
//  Desi Dime
//
//  Created by iViprak1 on 27/01/16.
//  Copyright © 2016 jigar. All rights reserved.
//

#import "ViewController.h"
#import "Configuration.h"
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [btnTop setBackgroundColor:[UIColor colorWithRed:73.0/255 green:145.0/255 blue:223.0/255 alpha:1.0]];
    [btnTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPopular setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPopular setBackgroundColor:[UIColor whiteColor]];
    
        
              NSString *strString=[NSString stringWithFormat:@"%@%@",kDealUrl,kTopDeal];
        [self getdata:strString];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)alertmsg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Connection" message:@"Plz Check InternetConnection" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)getdata:(NSString*)passstring
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self alertmsg];
    }
    else
    {
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"7d7c5cacb355d043f07c7c9e4b38257ea5683f8d643b578683877a9b6a8bee1b" forHTTPHeaderField:@"X-Desidime-Client"];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
    [manager GET:passstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         dataDic=responseObject;
         
         arraydata=[[responseObject objectForKey:@"deals"]objectForKey:@"data"];
         
         NSLog(@"json: %@", arraydata);
         [tableview reloadData];
         [spinner stopAnimating];

         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    }
   
}
- (IBAction)btnClickTop:(UIButton *)sender
{
    [btnTop setBackgroundColor:[UIColor colorWithRed:73.0/255 green:145.0/255 blue:223.0/255 alpha:1.0]];
    [btnTop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPopular setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPopular setBackgroundColor:[UIColor whiteColor]];

    
    NSString *strString=[NSString stringWithFormat:@"%@%@",kDealUrl,kTopDeal];
    
    [self getdata:strString];
  
}
- (IBAction)btnClcikPolular:(UIButton *)sender
{
    
    [btnPopular setBackgroundColor:[UIColor colorWithRed:73.0/255 green:145.0/255 blue:223.0/255 alpha:1.0]];
    [btnPopular setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnTop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTop setBackgroundColor:[UIColor whiteColor]];

    NSString *strString=[NSString stringWithFormat:@"%@%@",kDealUrl,kPopularDeal];
    
    [self getdata:strString];
   
}

#pragma uitableview Delegatemethod
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arraydata.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    
    customcell *cell = (customcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell==nil)
    {
        cell=[[customcell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.lbltitle.text=[[arraydata objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    NSURL *url = [NSURL URLWithString:[[arraydata objectAtIndex:indexPath.row] objectForKey: @"image"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"imageNotFound.png"];
    [cell.imgProduct setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       cell.imgProduct.image = image;
                                       
                                   } failure:nil];

    return cell;
}

@end
