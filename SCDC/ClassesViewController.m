//
//  ClassesViewController.m
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ClassesViewController.h"

@interface ClassesViewController ()

@end

@implementation ClassesViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    name = [NSMutableArray arrayWithObjects:@"Introduction to MS Powerpoint",@"Introduction to Multimedia", @"Introduction to Basic Computer Skills",@"Introduction to MS Word ", @"Introduction to Basic Computers ",nil];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *nameIdentifier = @"classList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    UILabel *classNameLabel = (UILabel *)[cell viewWithTag:1];
    
    classNameLabel.text = name[indexPath.row];
    
    return cell;
}



@end
