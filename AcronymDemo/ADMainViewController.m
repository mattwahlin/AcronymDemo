//
//  ADMainViewController.m
//  AcronymDemo
//
//  Created by Matthew Wahlin on 12/8/15.
//  Copyright © 2015 Wahlin Consulting. All rights reserved.
//

#import "ADMainViewController.h"

@interface ADMainViewController ()

@end

@implementation ADMainViewController

#define labelBoldTextFont [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]
#define cellVerticalPadding 10
NSString * const AIBaseURL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py?";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self resetContent];
    
    // Only alpha-numeric characters are allowed to enter in textfield. below set has the disallowed characters
    self.disallowedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // reset All content on screen when user starts entering any text
    [self resetContent];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Textfield is disabled till user enters atleast one character.
    // Dismiss Keyboard on return
    [textField resignFirstResponder];
    if(![textField.text isEqualToString:@""]){
        
        [self fetchDefinitionsForAcronym:textField.text];
    }
    
    return YES;
    
}


-(BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    
    return (newLength <= 30 || ([string rangeOfString: @"\n"].location != NSNotFound)) && ([string rangeOfCharacterFromSet:self.disallowedCharacters].location == NSNotFound);
}


#pragma mark- UITableView Datasource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.acronym.definitions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"AcronymDefinitionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    MWDefinition *definition = [self.acronym.definitions objectAtIndex:indexPath.row];
    cell.textLabel.text = definition.meaning;
    
    
    return cell;
}

#pragma mark- UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Calculate height required for title text and subtitle text. Then add padding above and below.
    MWDefinition *definition = [self.acronym.definitions objectAtIndex:indexPath.row];
    
    CGFloat titleHeight = [self heightForText:[definition meaning] withFont:labelBoldTextFont];
    
    
    return titleHeight + 2 * cellVerticalPadding;
    
}

#pragma mark - Web service
-(void) fetchDefinitionsForAcronym: (NSString *) acronym {
    
    NSDictionary *parameters = @{@"sf": acronym};
    
    // show loading indicator when web service is made
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ADNetworkClient sharedManager] getResponseForURLString:AIBaseURL
                                                  Parameters:parameters
        success:^(NSURLSessionDataTask *task, MWAcronym *acronym) {
                                                         
          [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.acronym = acronym;
            if (self.acronym && self.acronym.definitions.count > 0) {
                [self.acronymTableView setHidden:NO];
                [self.acronymTableView setContentOffset:CGPointZero animated:NO];
                [self.acronymTableView reloadData];
            }
            else{
                // show no results alerts
                [self showErrorAlertWithTitle:NSLocalizedString(@"NoResultsTitle", @"") message:[NSString stringWithFormat:NSLocalizedString(@"NoResultsMessage", @""),self.textField.text]];
            }
                                                         
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                         
            // show error alert with error description
            [self showErrorAlertWithTitle:nil message:error.localizedDescription];
                                                         
    }];
    
}


#pragma mark - Helper methods

-(void) resetContent{
    [self.acronymTableView setHidden:YES];
    self.acronym = nil;
}

-(CGFloat) heightForText:(NSString *) text withFont:(UIFont *) font {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.acronymTableView.frame.size.width - 50, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}

#pragma mark - Error handling

-(void)showErrorAlertWithTitle:(NSString *) title message:(NSString *) message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alertView show];
}



@end
