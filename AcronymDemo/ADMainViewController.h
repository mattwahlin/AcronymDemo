//
//  ADMainViewController.h
//  AcronymDemo
//
//  Created by Matthew Wahlin on 12/8/15.
//  Copyright © 2015 Wahlin Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWAcronym.h"
#import "MWDefinition.h"
#import "MBProgressHUD.h"
#import "ADNetworkClient.h"




@interface ADMainViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MWAcronym *acronym;
@property (nonatomic, weak) IBOutlet UITableView *acronymTableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSCharacterSet *disallowedCharacters;

@end

