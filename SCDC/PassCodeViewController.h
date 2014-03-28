//
//  PassCodeViewController.h
//  SCDC
//
//  Created by Leen  on 2/17/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define pass @"1234"

@interface PassCodeViewController : UIViewController {

   IBOutlet UITextField *passwordField;
}

-(void) alertUserOfIncorrectPasscode;
-(IBAction)isPasscodeCorrect:(id)sender;

@end
