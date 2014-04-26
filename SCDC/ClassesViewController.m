//
//  ClassesViewController.m
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ClassesViewController.h"
#import "AttendanceViewController.h"
#import "AppDelegate.h"
#import "DatabaseAccess.h"
#import "UIViewController+CWPopup.h"
#import "FTPHelper.h"
#import "FMDatabase.h"
#import "Utility.h"


@interface ClassesViewController ()

@end

@implementation ClassesViewController

@synthesize classes;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateClasses];
    
    //    self.clearsSelectionOnViewWillAppear = NO;
    
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"Number of classess =  %lu", (unsigned long)self.classes.count);
    
    //
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    
    //
    
    [appDelegate createAndCheckWithRemote:self];
    
    //Set navBar title text color to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.useBlurForPopup = YES;
    
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
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [classes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *nameIdentifier = @"classList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nameIdentifier];
    
    ClassInfo *class = [self.classes objectAtIndex:[indexPath row]];
    
    //    UILabel *classNameLabel = (UILabel *)[cell viewWithTag:1];
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ ",class.name]];
    
    //    cell.textLabel.textColor = [UIColor whiteColor];
    
    //     cell.backgroundColor = [UIColor clearColor];
    //    cell.backgroundColor = [UIColor colorWithWhite:1.5 alpha:.5];
    
    
    //    NSLog(@"Class is %@", class.name);
    //    classNameLabel.text = class.name;
    
    return cell;
}




//Solution with a good explanation is in this link : https://developer.apple.com/library/ios/documentation/userexperience/conceptual/tableview_iphone/TableViewAndDataModel/TableViewAndDataModel.html
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"temp"])  {
        
        UIButton * button = sender;
        UITableViewCell * cell = (id)button.superview.superview.superview;
        NSLog(@"%@", cell);
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        AttendanceViewController *destViewController = segue.destinationViewController;
        destViewController.classPassed = [classes objectAtIndex:indexPath.row];
        
    }
}

-(IBAction) TakeAttendance:(id)sender
{
    
    //Disable scrolling when displaying popup
    self.tableView.scrollEnabled = NO;
    
    
    AttendanceViewController *AttendanceVC = [[AttendanceViewController alloc] init];
    
    //Get the class to take attendance for
    UIButton * button = sender;
    UITableViewCell * cell = (id)button.superview.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    AttendanceVC.classPassed = [classes objectAtIndex:indexPath.row];
    
    //Create the Attendance table view with a nav bar
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:AttendanceVC];
    
    //Create a delgate to communicate that the user is done
    AttendanceVC.delegate = self;
    
    
    
    //Works -- but no nav bar
    //    [self presentPopupViewController:AttendanceVC animated:YES completion:^(void) {
    //        NSLog(@"popup view presented");
    //    }];
    
    
    
    //Set the frame for our popup view
    navController.view.frame = CGRectMake(0, 0, 250, 350);
    
    
    
    //A compromise since I haven't found a way to get the pop up to show up other than the top
    self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
    
    
    //Show the pop up
    [self presentPopupViewController:navController animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
    
    
    
    
    //Original -- No popup
    //    [self performSegueWithIdentifier:@"temp" sender:sender];
    
    
}

- (void)dismiss:(BOOL)finished
{
    NSLog(@"Communication succesful");
    [self dismissPopop:self];
}

- (IBAction)dismissPopop:(id)sender {
    
    //Dismiss popup
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
    }
    
    //Enable scrolling when popup is dismissed
    self.tableView.scrollEnabled = YES;
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
