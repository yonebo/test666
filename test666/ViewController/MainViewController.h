//
//  MainViewController.h
//  test666
//
//  Created by MacPro01 on 2013/11/05.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface MainViewController : UIViewController
{
    IBOutlet UITextField *tfKey;
    IBOutlet UITextField *tfTData;
    IBOutlet UITextField *tfIData;
    IBOutlet UITextField *tfBData;
    
    IBOutlet UIButton *buttonSearch;
    IBOutlet UIButton *buttonRegistry;
    IBOutlet UIButton *buttonDelete;
    
    //IBOutlet UITableView *tvResult;
}

@property(nonatomic, retain) IBOutlet UITextField *tfKey;
@property(nonatomic, retain) IBOutlet UITextField *tfTData;
@property(nonatomic, retain) IBOutlet UITextField *tfIData;
@property(nonatomic, retain) IBOutlet UITextField *tfBData;

@property(nonatomic, retain) IBOutlet UIButton *buttonSearch;
- (IBAction)SelectData:(id)sender;

@property(nonatomic, retain) IBOutlet UIButton *buttonRegistry;
- (IBAction)InsertData:(id)sender;

@property(nonatomic, retain) IBOutlet UIButton *buttonDelete;
- (IBAction)DeleteData:(id)sender;

- (IBAction)closeSoftwareKeyboard:(id)sender;

@end
