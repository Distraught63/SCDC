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
    
    self.classPassed = self.classPassed;
    [self populatesStudents];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentList" forIndexPath:indexPath];
    
    Student *student = [self.students objectAtIndex:[indexPath row]];
    
    UILabel *studentNameLabel = (UILabel *)[cell viewWithTag:1];
    
    studentNameLabel.text = student.firstName;

    return cell;
}

-(void) populatesStudents
{
    self.students = [[NSMutableArray alloc] init];
        
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
        
    self.students = [db getStudentsInClass:classPassed];
    
    NSLog(@"Number of students in class is: %lud", (unsigned long)self.students.count);
    
}


@end
