//
//  MainMenuiPadViewController.m
//  SCDC
//
//  Created by Veena Dali on 4/19/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "MainMenuiPadViewController.h"

@interface MainMenuiPadViewController ()

@end

@implementation MainMenuiPadViewController
- (IBAction) unwindMainMenuiPad:(UIStoryboardSegue *)segue
{
    
}


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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BusiPad.png"]];
    self.view.backgroundColor = background;
	// Do any additional setup after loading the view.
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



@end
