//
//  ViewController.m
//  SCDC
//
//  Created by Leen  on 2/8/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ViewController.h"
#import "TSQCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    name = [NSMutableArray arrayWithObjects:@"Introduction to MS Powerpoint",@"Introduction to Multimedia", @"Introduction to Basic Computer Skills",@"Introduction to MS Word ", @"Introduction to Basic Computers ",nil];
    
    
    location= [NSMutableArray arrayWithObjects:@"Bell Technology Center", @"Bell Technology Center", @"Little Bear Park", @"Bell Technology Center",@"Bell Community Center",nil];
    
    
    days = [NSMutableArray arrayWithObjects:@"Tuesdays & Thursdays", @"Mondays and Wednesday",@"Tuesdays & Thursdays", @"Tuesdays & Thursdays",@"Wednesdays", nil];
    
    
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
    static NSString *nameIdentifier = @"classes";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    UILabel *classNameLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *locationNameLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:5];
    UILabel *daysNameLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *daysLabel = (UILabel *)[cell viewWithTag:3];
    
    daysNameLabel.text = @"Days: ";
    daysLabel.text = days[indexPath.row];
    
    locationNameLabel.text = @"Location: ";
    
    locationLabel.text = location[indexPath.row];
    
    classNameLabel.text = name[indexPath.row];
    
    return cell;
}



@end
