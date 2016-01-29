//
//  ViewController.h
//  Desi Dime
//
//  Created by iViprak1 on 27/01/16.
//  Copyright © 2016 jigar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customcell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *dataDic;
    NSMutableArray *arraydata;
    
    UIActivityIndicatorView *activityIndicator;
    
    IBOutlet UIButton *btnTop;
    IBOutlet UIButton *btnPopular;


    
    IBOutlet UITableView *tableview;
}


-(void)getdata:(NSString*)passstring;


- (IBAction)btnClickTop:(UIButton *)sender;
- (IBAction)btnClcikPolular:(UIButton *)sender;


@end

