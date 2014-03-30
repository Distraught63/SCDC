//
//  AttendanceViewController.h
//  SCDC
//
//  Created by Leen  on 3/28/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface AttendanceViewController : UITableViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSMutableArray *students;
@property (nonatomic, strong) ClassInfo *classPassed;

-(void) populateStudents;

-(IBAction) saveAttendance:(id)sender;

@end
