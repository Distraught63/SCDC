//
//  FTPHelper.h
//  UItableView Example
//
//  Created by Leen  on 3/12/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//


//Note: Code between two // are changes made by Tim so that the view is updated when the download is complete.

#import <Foundation/Foundation.h>

//---------- include files
#import "BRRequestListDirectory.h"
#import "BRRequestCreateDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "BRRequest+_UserData.h"

//
@class ClassesViewController;
//


#define path1 @"/Dropbox/scdc.db"
#define pathCSV @"/Dropbox/"
#define hostname1 @"155.41.80.8"
#define username1 @"leen"
#define password1 @"S"

@interface FTPHelper : NSObject <BRRequestDelegate>
{
    BRRequestCreateDirectory *createDir;
    BRRequestDelete * deleteDir;
    BRRequestListDirectory *listDir;
    
    BRRequestDownload * downloadFile;
    BRRequestUpload *uploadFile;
    BRRequestDelete *deleteFile;
    
    NSMutableData *downloadData;
    NSData *uploadData;
}

//
@property (nonatomic,weak) ClassesViewController* delegate;
//
- (IBAction)downloadFile: (id) sender;

- (void) uploadCSV: (NSString *) path fileName: (NSString * ) filename;

- (void) uploadFile ;

- (IBAction) downloadStudents: (id) sender;
- (IBAction) downloadClasses: (id) sender;
- (IBAction) downloadRegistration: (id) sender;

@end
