//
//  PassCodeViewController.h
//  SCDC
//
//  Created by Leen  on 2/17/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define pass @"1234"
#define usernamescdc @"SCDCadmin"

@interface PassCodeViewController : UIViewController <UITextFieldDelegate> {

}

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;


-(void) alertUserOfIncorrectPasscode;
-(IBAction)isPasscodeCorrect:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
