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
    
    
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.classPassed = self.classPassed;
    self.view.frame = CGRectMake(20, 70, 280 , 450);
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
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentList" forIndexPath:indexPath];
    
    Student *student = [self.students objectAtIndex:[indexPath row]];
    
    UILabel *studentNameLabel = (UILabel *)[cell viewWithTag:1];
    
    studentNameLabel.text = student.firstName;

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
    
    [self performSegueWithIdentifier: @"unwindToClassList" sender: self];
    
//    [self.navigationController popViewControllerAnimated:YES];

}





@end
