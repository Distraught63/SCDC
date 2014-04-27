//
//  AttendanceViewController.h
//  SCDC
//
//  Created by Leen  on 3/28/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DatabaseAccess.h"
#import "ExportHelper.h"


#import "AttendanceViewControllerDelegate.h"

@protocol AttendanceViewControllerDelegate;
@class ClassesViewController;


@interface AttendanceViewController : UITableViewController
{
//    id<AttendanceViewControllerDelegate> delegate;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSMutableArray *students;
@property (nonatomic, strong) ClassInfo *classPassed;


-(void) populateStudents;

-(IBAction) saveAttendance:(id)sender;

@property (retain) id delegate;

@end


//@protocol AttendanceViewControllerDelegate <NSObject>
//
//- (void)dismiss:(AttendanceViewController*)viewController didFinish:(BOOL)finished;
//
//@end
