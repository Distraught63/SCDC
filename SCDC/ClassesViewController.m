//
//  ClassesViewController.m
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ClassesViewController.h"
#import "Classes.h"
#import "AttendanceViewController.h"
#import "AppDelegate.h"

@interface ClassesViewController ()

@end

@implementation ClassesViewController

@synthesize classes;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateClasses];
    
     NSLog(@"Number of classess =  %lu", (unsigned long)self.classes.count);
    
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

- (IBAction)unwindToClassess:(UIStoryboardSegue *)segue;
{
    //To Show changes (The added customer)
    
//    AddCustomerViewController *source = [segue sourceViewController];
//    Customer *newCustomer = source.customer;
//    if (newCustomer != nil) {
//        [self.class addObject:newClass];
//        [self.tableView reloadData];
//    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Number of classes is %lu", classes.count);
    return [classes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *nameIdentifier = @"classList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    ClassInfo *class = [self.classes objectAtIndex:[indexPath row]];
    
//    UILabel *classNameLabel = (UILabel *)[cell viewWithTag:1];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ ",class.name]];
    return cell;
    
    
//    NSLog(@"Class is %@", class.name);
//    classNameLabel.text = class.name;
    
    return cell;
}




//Solution with a good explanation is in this link : https://developer.apple.com/library/ios/documentation/userexperience/conceptual/tableview_iphone/TableViewAndDataModel/TableViewAndDataModel.html
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"temp"])  {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AttendanceViewController *destViewController = segue.destinationViewController;
        destViewController.classPassed = [classes objectAtIndex:indexPath.row];
        
    }
}

//Refreshes table view when download is done.
//
-(void)ftpDidFinishRefreshing
{
    [self populateClasses];
    [self.tableView reloadData];
}
//



@end
