//
//  AdminMenuViewController.m
//  SCDC
//
//  Created by Leen  on 4/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "AdminMenuViewController.h"
#import "ImportHelper.h"
#import "ExportHelper.h"
#import "Reachability.h"

@interface AdminMenuViewController ()

@end

@implementation AdminMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         [[UINavigationBar appearance] setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Bus.png"]];
    self.view.backgroundColor = background;
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus != NotReachable)
        
    {
        // Write your code here.
        
        NSLog(@"Network Found");
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection!" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
}

-(IBAction)import:(id)sender
{
    NSLog(@"IMPORITNG DATABASE....");
    ImportHelper *import = [[ImportHelper alloc] init];
    
    [import importAll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) exportAttendance:(id)sender
{
    ExportHelper *export = [[ExportHelper alloc] init];
    
    [export exportAll];
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
    [self.navigationController.navigationBar setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

@end
