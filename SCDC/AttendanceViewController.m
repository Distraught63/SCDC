//
//  AttendanceViewController.m
//  SCDC
//
//  Created by Leen  on 3/28/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "AttendanceViewController.h"


@interface AttendanceViewController ()

@end

@implementation AttendanceViewController

@synthesize classPassed;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the classPassed to be the classPassed by the classesViewController
    self.classPassed = self.classPassed;
    
    //Get students to populate cells
    [self populateStudents];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Student *student = [self.students objectAtIndex:[indexPath row]];
    student.attendedClass = YES;
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier =@"studentList";
    //here you check for PreCreated cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    Student *student = [self.students objectAtIndex:[indexPath row]];
    
    
    UILabel *studentNameLabel = [cell textLabel];
    
    studentNameLabel.text = [NSString stringWithFormat:@"%@, %@", student.firstName, student.lastName];
    //    studentNameLabel.text = student.firstName;
    
    return cell;
}

-(void) populateStudents
{
    self.students = [[NSMutableArray alloc] init];
    
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    self.students = [db getStudentsInClass:classPassed];
    
    NSLog(@"Number of students in class is: %lu", (unsigned long)self.students.count);
    
}

-(IBAction) saveAttendance:(id)sender
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    [db updateAttendance:self.students theClass:self.classPassed];
    //    [db updateAttendance:self.students];
    
    ExportHelper *eh = [[ExportHelper alloc] init];
    [eh exportAttendance: self.classPassed];
    
    FTPHelper *ftp = [[FTPHelper alloc] init];
    
    [ftp uploadFile];
    
    
    //Ways to go back to the previous view controller
    
    //    [self performSegueWithIdentifier: @"unwindToClassList" sender: self];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    //Tell Classes that the attendance view is no longer needed
    id<AttendanceViewControllerDelegate> strongDelegate = self.delegate;
    
//    [strongDelegate dismiss:self didFinish:YES];
       [strongDelegate dismiss:YES];
    
}

-(IBAction)cancel:(id)sender
{
    NSLog(@"Cancel Called");
    
    //Tell Classes that the attendance view is no longer needed
    id<AttendanceViewControllerDelegate> strongDelegate = self.delegate;
    
//    [strongDelegate dismiss:self didFinish:YES];
    
    [strongDelegate dismiss:YES];
    
}





-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar Background
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UINavigationItem *navItem = self.navigationItem;
    
    //Create NavBar buttons
    
    //Create save button with white color -- Calls saveAttendance method
    UIBarButtonItem  *save= [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveAttendance:)];
    save.tintColor = [UIColor whiteColor];
    
    //Create cancel button with white color
    UIBarButtonItem  *cancel= [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    cancel.tintColor = [UIColor whiteColor];
    
    
    //Add buttons to navigation bar
    navItem.rightBarButtonItem = save;
    navItem.leftBarButtonItem = cancel;
    
    
    // this will appear as the title in the navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"Attendance";
    [label sizeToFit];
    
    
}

@end


