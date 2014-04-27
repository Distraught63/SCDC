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

@synthesize passwordField, usernameField;

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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Bus.png"]];
    self.view.backgroundColor = background;
    
    //Connect textfields to the keyboard delegate in order to dimiss keyboard
    passwordField.delegate = self;
    usernameField.delegate = self;

    
    
}

-(IBAction)isPasscodeCorrect:(id)sender
{
    
    //Checks if the password entered by the user equals passcode, otherwise notify of incorrect attempt
    if ([usernameField.text  isEqual: faculty] && [passwordField.text  isEqual: pass])
    {
        [self performSegueWithIdentifier: @"PassToClasses" sender: self];
    }
    else if ([usernameField.text  isEqual: admin] && [passwordField.text  isEqual: pass])
    {
         [self performSegueWithIdentifier: @"PassToAdmin" sender: self];
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
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password or Username!" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Code for textfield


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
