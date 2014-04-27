//
//  CalendarClassInfoTableViewController.m
//  SCDC
//
//  Created by Leen  on 4/27/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "CalendarClassInfoTableViewController.h"
#import "ClassInfo.h"
#import "DatabaseAccess.h"

@interface CalendarClassInfoTableViewController ()


@end

@implementation CalendarClassInfoTableViewController

@synthesize classes;

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
    
    //Populate Cells
    [self populateClasses];
    
    
    
    
}


-(IBAction)cancel:(id)sender
{
    NSLog(@"Cancel Called");
    
    //Tell the calendar that the user is done looking at this information
    id<ClassesInfoViewControllerDelegate> strongDelegate = self.delegate;
    
    
    [strongDelegate dismiss:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) populateClasses
{
    
    NSDateFormatter* day = [[NSDateFormatter alloc] init];
    [day setDateFormat: @"EEEE"];
    
    NSString *days = [day stringFromDate:self.date];
    days = [days lowercaseString];
    
    NSMutableArray *temp= [[NSMutableArray alloc] init];
    
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    temp = [db getClasses];
    
    for (ClassInfo *c in temp) {
        if (![c.day rangeOfString:days].location == NSNotFound) {
            [self.classes addObject:c];
        }
    }
    
    NSLog(@"Number of Classes == %lu", (unsigned long)self.classes.count);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.classes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier =@"classInfo";
    //here you check for PreCreated cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ClassInfo *cls = [self.classes objectAtIndex:[indexPath row]];
    
    //Link labels
    UILabel *name = [cell viewWithTag:1] ;
    UILabel *day = [cell viewWithTag:2];
    UILabel *time = [cell viewWithTag:3];
    UILabel *instructor = [cell viewWithTag:4];
    UILabel *location = [cell viewWithTag:5];
    UILabel *type = [cell viewWithTag:6];
    
    
    //Add text to labels
    name.text = cls.name;
    day.text = cls.day;
    time.text = cls.time;
    instructor.text = cls.instructor;
    location.text = cls.location;
    type.text = cls.type;
    
    
    
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassInfo *cls = [self.classes objectAtIndex:[indexPath row]];
    cls.registeredForClass = YES;
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    //Set Navigation Bar Background
    UIImage *image = [UIImage imageNamed: @"UpperBarNewColor.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UINavigationItem *navItem = self.navigationItem;
    
    //Create NavBar buttons
    
    
    //Create cancel button with white color
    UIBarButtonItem  *cancel= [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss:)];
    cancel.tintColor = [UIColor whiteColor];
    
    
    //Add buttons to navigation bar
    navItem.leftBarButtonItem = cancel;
    
    
    // this will appear as the title in the navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"Classes";
    [label sizeToFit];
    
    
}

@end
