//
//  PassCodeViewController.m
//  SCDC
//
//  Created by Leen  on 2/17/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "PassCodeViewController.h"
#import "ClassesViewController.h"

@interface PassCodeViewController ()

@end

@implementation PassCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"scdc.jpg"]];
    self.view.backgroundColor = background;
    
	// Do any additional setup after loading the view.
    
}

-(IBAction)isPasscodeCorrect:(id)sender
{
    
    //Checks if the password entered by the user equals passcode, otherwise notify of incorrect attempt
    if (passwordField.text.length == pass.length && [passwordField.text  isEqual: pass])
    {
        [self performSegueWithIdentifier: @"PassToClasses" sender: self];
    }
    else
    {
        [self alertUserOfIncorrectPasscode];
    }
    
    
}


/*
 Displays an alert that notifies the user of an incorrect passcode.
 */
-(void) alertUserOfIncorrectPasscode
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
