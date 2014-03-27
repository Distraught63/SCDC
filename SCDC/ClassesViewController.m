//
//  ClassesViewController.m
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ClassesViewController.h"
#import "Classes.h"
#import "AddCustomerViewController.h"
#import "AppDelegate.h"

@interface ClassesViewController ()

@end

@implementation ClassesViewController

@synthesize classes;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateClasses];
    
    //
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    
    //
    
    [appDelegate createAndCheckWithRemote:self];
}


//Gets the list of classes from the database and stores them in the classes array.In other words, populates the classes array.
-(void) populateClasses
{
    self.classes = [[NSMutableArray alloc] init];
    
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    self.classes = [db getClasses];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToClassess:(UIStoryboardSegue *)segue:(UIStoryboardSegue *)segue
{
    //To Show changes (The added customer)
    
//    AddCustomerViewController *source = [segue sourceViewController];
//    Customer *newCustomer = source.customer;
//    if (newCustomer != nil) {
//        [self.class addObject:newClass];
//        [self.tableView reloadData];
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [classes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *nameIdentifier = @"classList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    UILabel *classNameLabel = (UILabel *)[cell viewWithTag:1];
    
    classNameLabel.text = classes[indexPath.row];
    
    return cell;
}



@end
