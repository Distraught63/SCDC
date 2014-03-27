//
//  FTPHelper.h
//  UItableView Example
//
//  Created by Leen  on 3/12/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

//---------- include files
#import "BRRequestListDirectory.h"
#import "BRRequestCreateDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "BRRequest+_UserData.h"
//
@class CustomersViewController;
//


#define path1 @"/Dropbox/Customers.db"//@"Users/Leen/Dropbox/" //@"/public_html/SCDC/AppFiles/Customers.db"
#define hostname1 @"155.41.119.21"//@"ftp.leenalshenibr.com"
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
@property (nonatomic,weak) CustomersViewController * delegate;
//
- (IBAction)downloadFile: (id) sender;

- (void) uploadFile ;

@end
