//
//  ClassesViewController.h
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DatabaseAccess.h"
//#import "UIViewController+CWPopup.h"
//#import "FTPHelper.h"
//#import "FMDatabase.h"
//#import "Utility.h"
//#import "AttendanceViewController.h"
#import "AttendanceViewControllerDelegate.h"

@interface ClassesViewController : UITableViewController <AttendanceViewControllerDelegate>{
}


@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *classes;

//Gets the array of classes
-(void) populateClasses;

//Navigate back to this view
- (IBAction)unwindToClassess:(UIStoryboardSegue *)segue;

//Refresh the view when the download is complete
-(void) ftpDidFinishRefreshing;

- (IBAction)dismissPopop:(id)sender;

@end
