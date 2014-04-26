//
//  MainMenuViewController.m
//  SCDC
//
//  Created by Leen  on 2/17/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "MainMenuViewController.h"
#import "Reachability.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (IBAction) unwindMainMenu:(UIStoryboardSegue *)segue
{
    
}


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
    
    [[UINavigationBar appearance] setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];

    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BusMain.png"]];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Connection!" message:@"Please check your internet connection. \n Warning: Information may not be up to date without network connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"scdc.jpg"]];
//    self.view.backgroundColor = background;
	// Do any additional setup after loading the view.
    
//    [self.navigationController set];
//    [[UINavigationBar appearance] setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearanceWhenContainedIn:[MainMenuViewController class], nil];
    
//    [[UINavigationBar appearance] setBackgroundImage: Nil] forBarMetrics:UIBarMetricsDefault];
}
-(void)viewDidAppear:(BOOL)animated
{
//     [[UINavigationBar appearance] setBackgroundImage:Nil forBarMetrics:UIBarMetricsDefault];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) openWebsite:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.scdcorp.org/"];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)viewWillDisappear:(BOOL)animated
{
//        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"UpperBarNewColor.png"] forBarMetrics:UIBarMetricsDefault];
}




@end
