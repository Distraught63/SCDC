//
//  AddStudentViewController.m
//  SCDC
//
//  Created by Leen  on 4/25/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "AddStudentViewController.h"
#import "DatabaseAccess.h"
#import "FMDatabase.h"

@interface AddStudentViewController ()

@end

@implementation AddStudentViewController

@synthesize FirstName,LastName,email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Bus.png"]];
    self.view.backgroundColor = background;
    
    FirstName.delegate = self;
    LastName.delegate = self;
    email.delegate = self;
}

/*Add student to database with the information from the text field*/
-(IBAction)addStudent:(id)sender
{
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    Student *temp = [[Student alloc]init];
    
    temp.firstName = FirstName.text;
    temp.lastName = LastName.text;
    temp.email = email.text;
    
    [db executeUpdate:@"INSERT INTO student (firstname, lastname, email) VALUES (?,?,?);", FirstName.text,LastName.text,email.text];
    
    
    //Testing if items where inserted correctly to database
    FMResultSet *check = [db executeQuery:@"select * from student where firstname =?", FirstName.text ];
    NSLog(@"Items were inserted successfully? %d", check.next);
    

    [db close];
    
    FTPHelper *ftp = [[FTPHelper alloc] init];
    [ftp uploadFile];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
