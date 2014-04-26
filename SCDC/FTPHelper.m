//
//  FTPHelper.m
//  UItableView Example
//
//  Created by Leen  on 3/12/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "FTPHelper.h"
#import "Utility.h"
#import "ClassesViewController.h"
#import "ImportHelper.h"

@implementation FTPHelper


//For syncing
- (IBAction) downloadFile: (id) sender
{
    
    downloadData = [NSMutableData dataWithCapacity: 1];
    
    downloadFile = [[BRRequestDownload alloc] initWithDelegate: self];
    
    //
    ClassesViewController * vc = sender;
    
    //
    
    self.delegate = vc;
    //----- for anonymous login just leave the username and password nil
    downloadFile.path = path1;
    downloadFile.hostname = hostname1;
    downloadFile.username = username1;
    downloadFile.password = password1;
    
    NSLog(@"Download Started!!");
    //we start the request
    [downloadFile start];
    
}

//Import 

- (IBAction) downloadStudents: (id) sender
{
    
    downloadData = [NSMutableData dataWithCapacity: 1];
    
    downloadFile = [[BRRequestDownload alloc] initWithDelegate: self];
    
    //
    ClassesViewController * vc = sender;
    //
    
    self.delegate = vc;
    //----- for anonymous login just leave the username and password nil
    downloadFile.path = [NSString stringWithFormat:@"%@%@", pathCSV, @"students.csv"];
    downloadFile.hostname = hostname1;
    downloadFile.username = username1;
    downloadFile.password = password1;
    
    NSLog(@"Download Started!!");
    //we start the request
    [downloadFile start];
    
}

- (IBAction) downloadClasses: (id) sender
{
    
    downloadData = [NSMutableData dataWithCapacity: 1];
    
    downloadFile = [[BRRequestDownload alloc] initWithDelegate: self];
    
    //
    ClassesViewController * vc = sender;
    //
    
    self.delegate = vc;
    //----- for anonymous login just leave the username and password nil
    downloadFile.path = [NSString stringWithFormat:@"%@%@", pathCSV, @"classes.csv"];
    downloadFile.hostname = hostname1;
    downloadFile.username = username1;
    downloadFile.password = password1;
    
    NSLog(@"Download Started!!");
    //we start the request
    [downloadFile start];
    
}

- (IBAction) downloadRegistration: (id) sender
{
    
    downloadData = [NSMutableData dataWithCapacity: 1];
    
    downloadFile = [[BRRequestDownload alloc] initWithDelegate: self];
    
    //
    ClassesViewController * vc = sender;
    //
    
    self.delegate = vc;
    //----- for anonymous login just leave the username and password nil
    downloadFile.path = [NSString stringWithFormat:@"%@%@", pathCSV, @"registration.csv"];
    downloadFile.hostname = hostname1;
    downloadFile.username = username1;
    downloadFile.password = password1;
    
    NSLog(@"Download Started!!");
    //we start the request
    [downloadFile start];
    
}

- (void) uploadFile
{
    //----- get the file to upload as an NSData object
    uploadData = [NSData dataWithContentsOfFile: [Utility getDatabasePath]];
    
    uploadFile = [[BRRequestUpload alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    uploadFile.path = path1;
    uploadFile.hostname = hostname1;
    uploadFile.username = username1;
    uploadFile.password = password1;
    
    //we start the request
    NSLog(@"Upload Starting.....");
    [uploadFile start];
}

- (void) uploadCSV: (NSString *) path fileName: (NSString * ) filename
{
    //----- get the file to upload as an NSData object
    uploadData = [NSData dataWithContentsOfFile: path];
    
    uploadFile = [[BRRequestUpload alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    uploadFile.path = [NSString stringWithFormat:@"%@%@",pathCSV, filename];
    uploadFile.hostname = hostname1;
    uploadFile.username = username1;
    uploadFile.password = password1;
    
    //we start the request
    NSLog(@"Upload CSV Starting.....");
    [uploadFile start];
}

- (IBAction) createDirectory:(id)sender
{
    createDir = [[BRRequestCreateDirectory alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    createDir.path = path1;
    createDir.hostname = hostname1;
    createDir.username = username1;
    createDir.password = password1;
    
    //we start the request
    [createDir start];
}

- (IBAction) deleteDirectory:(id)sender
{
    deleteDir = [[BRRequestDelete alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    deleteDir.path = path1;
    deleteDir.hostname = hostname1;
    deleteDir.username = username1;
    deleteDir.password = password1;
    
    //we start the request
    [deleteDir start];
}

- (IBAction) listDirectory:(id)sender
{
    listDir = [[BRRequestListDirectory alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    listDir.path = path1;
    listDir.hostname = hostname1;
    listDir.username = username1;
    listDir.password = password1;
    
    [listDir start];
}

- (IBAction) deleteFile: (id) sender
{
    deleteFile = [[BRRequestDelete alloc] initWithDelegate: self];
    
    //----- for anonymous login just leave the username and password nil
    deleteFile.path = path1;
    deleteFile.hostname = hostname1;
    deleteFile.username = username1;
    deleteFile.password = password1;
    
    //----- we start the request
    [deleteFile start];
}

- (IBAction) cancelAction :(id)sender
{
    if (uploadFile)
    {
        //----- Remove comment if you do not want success delegate called
        //----- upon completion of the cancel
        // uploadFile.cancelDoesNotCallDelegate = TRUE;
        [uploadFile cancelRequest];
    }
    
    if (downloadFile)
    {
        //----- Remove comment if you do not want success delegate called
        //----- upon completion of the cancel
        // downloadFile.cancelDoesNotCallDelegate = TRUE;
        [downloadFile cancelRequest];
    }
}

- (void) requestDataAvailable: (BRRequestDownload *) request;
{
    [downloadData appendData: request.receivedData];
    NSLog(@"Received: %lu", (unsigned long)[request.receivedData length]);
    NSLog(@"Size of Recieved Data is %lu", (unsigned long)downloadFile.receivedData.length);
    
}

-(BOOL) shouldOverwriteFileWithRequest: (BRRequest *) request
{
    //----- set this as appropriate if you want the file to be overwritten
    if (request == uploadFile)
    {
        //----- if uploading a file, we set it to YES
        return YES;
    }
    
    //----- anything else (directories, etc) we set to NO
    return NO;
}

- (NSData *) requestDataToSend: (BRRequestUpload *) request
{
    //----- returns data object or nil when complete
    //----- basically, first time we return the pointer to the NSData.
    //----- and BR will upload the data.
    //----- Second time we return nil which means no more data to send
    NSData *temp = uploadData;   // this is a shallow copy of the pointer
    
    uploadData = nil;            // next time around, return nil...
    
    return temp;
}

- (void) percentCompleted: (BRRequest *) request
{
    NSLog(@"%f completed...", request.percentCompleted);
}

- (void)requestCompleted:(BRRequest *)request
{
    NSLog(@"Transfer Succesful!!");
    //----- handle Create Directory
    if (request == createDir)
    {
        NSLog(@"%@ completed!", request);
        
        createDir = nil;
    }
    
    //----- handle Delete Directory
    if (request == deleteDir)
    {
        NSLog(@"%@ completed!", request);
        
        deleteDir = nil;
    }
    
    //----- handle List Directory
    if (request == listDir)
    {
        //----- called after 'request' is completed successfully
        NSLog(@"%@ completed!", request);
        
        //----- we print each of the file names
        for (NSDictionary *file in listDir.filesInfo)
        {
            NSLog(@"%@", [file objectForKey: (id) kCFFTPResourceName]);
        }
        
        
        listDir = nil;
        
    }
    
    //----- handle Download File
    if (request == downloadFile)
    {
        //called after 'request' is completed successfully
        
        NSData *data = downloadData;
        
//        NSString *downloadedFilePath = pathCSV;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *writePath;
        
        if ([downloadFile.path isEqualToString:[NSString stringWithFormat:@"%@%@", pathCSV, @"students.csv"]])
        {
            writePath = [Utility getStudentsPath];
        }
        
        else     if ([downloadFile.path isEqualToString:[NSString stringWithFormat:@"%@%@", pathCSV, @"classes.csv"]])
        {
            writePath = [Utility getClassesPath];
        }
        else     if ([downloadFile.path isEqualToString:[NSString stringWithFormat:@"%@%@", pathCSV, @"registration.csv"]])
        {
            writePath = [Utility getRegistrationPath];
        }
        else
        {
            writePath = [Utility getDatabasePath];
            
            //Inform classesViewController that the databases was downloaded
            [self.delegate ftpDidFinishRefreshing];
            
        }
        
        //Remove item at path
        [fileManager removeItemAtPath:writePath error:nil];
        
        //Write downloaded file to path
        [data writeToFile: writePath atomically:YES];
        
        //Delete the downloaded file
        downloadFile = nil;
        
    }
    
    if (request == uploadFile)
    {
        NSLog(@"%@ completed!", request);
        uploadFile = nil;
    }
    
    if (request == deleteFile)
    {
        NSLog(@"%@ completed!", request);
        deleteFile = nil;
    }
}

-(void) requestFailed:(BRRequest *) request
{
    NSLog(@"Request Failed");
    if (request == createDir)
    {
        NSLog(@"%@", request.error.message);
        
        createDir = nil;
    }
    
    if (request == deleteDir)
    {
        NSLog(@"%@", request.error.message);
        
        deleteDir = nil;
    }
    
    if (request == listDir)
    {
        NSLog(@"%@", request.error.message);
        
        listDir = nil;
    }
    
    if (request == downloadFile)
    {
        NSLog(@"%@", request.error.message);
        
        downloadFile = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to FTP Server!" message:@"Please check your connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        static BOOL alertShowen = NO;
        
        if(alertShowen == NO)
        {
            [alert show];
            alertShowen = YES;
        }
    }
    
    if (request == uploadFile)
    {
        NSLog(@"%@", request.error.message);
        NSLog(@"Upload failed");
        uploadFile = nil;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to FTP Server!" message:@"Please check your connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   
        static BOOL alertShowen = NO;
        
        if(alertShowen == NO)
        {
            [alert show];
            alertShowen = YES;
        }
    }
    
    if (request == deleteFile)
    {
        NSLog(@"%@", request.error.message);
        
        deleteFile = nil;
    }
}

@end
