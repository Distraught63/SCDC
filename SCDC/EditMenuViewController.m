//
//  EditMenuViewController.m
//  SCDC
//
//  Created by Leen  on 4/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "EditMenuViewController.h"
#import "AddStudentViewController.h"
#import "UIViewController+CWPopup.h"

@interface EditMenuViewController ()

@end

@implementation EditMenuViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addStudent:(id)sender
{
    AddStudentViewController *AddStudentVC = [[AddStudentViewController alloc] init];
    
    //Create the AddStudent table view with a nav bar
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:AddStudentVC];
  
    
    //Works -- but no nav bar
    //    [self presentPopupViewController:AttendanceVC animated:YES completion:^(void) {
    //        NSLog(@"popup view presented");
    //    }];
    
    
    
    //Set the frame for our popup view
    navController.view.frame = CGRectMake(0, 0, 250, 350);
    //Add UItext and labels to popup view
    UILabel *FirstName = [[UILabel alloc] initWithFrame:CGRectMake(25, 99, 184, 30)];
    
    //Show the pop up
    [self presentPopupViewController:navController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
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

-(void)viewWillDisappear:(BOOL)animated
{
}

@end
