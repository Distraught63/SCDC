//----------
//
//				BRRequestDownload.m
//
// filename:	BRRequestDownload.m
//
// author:		Created by Valentin Radu on 8/23/11.
//              Copyright 2011 Valentin Radu. All rights reserved.
//
//              Modified and/or redesigned by Lloyd Sargent to be ARC compliant.
//              Copyright 2012 Lloyd Sargent. All rights reserved.
//
// created:		Jul 04, 2012
//
// description:	
//
// notes:		none
//
// revisions:	
//
// license:     Permission is hereby granted, free of charge, to any person obtaining a copy
//              of this software and associated documentation files (the "Software"), to deal
//              in the Software without restriction, including without limitation the rights
//              to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//              copies of the Software, and to permit persons to whom the Software is
//              furnished to do so, subject to the following conditions:
//
//              The above copyright notice and this permission notice shall be included in
//              all copies or substantial portions of the Software.
//
//              THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//              IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//              FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//              AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//              LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//              OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//              THE SOFTWARE.
//



//---------- pragmas



//---------- include files
#import "BRRequestDownload.h"



//---------- enumerated data types



//---------- typedefs



//---------- definitions



//---------- structs



//---------- external functions



//---------- external variables



//---------- global functions



//---------- local functions



//---------- global variables



//---------- local variables



//---------- protocols



//---------- classes

@implementation BRRequestDownload

@synthesize receivedData;


//-----
//
//				start
//
// synopsis:	[self start];
//
// description:	start is designed to
//
// errors:		none
//
// returns:		none
//

- (void)start
{
    
    NSLog(@"Download Starting");
    NSLog(@"Delagate is %@", self.delegate);
    if (![self.delegate respondsToSelector:@selector(requestDataAvailable:)])
    {
         NSLog(@"Data NOT available!");
        [self.streamInfo streamError: self errorCode: kBRFTPClientMissingRequestDataAvailable];
        InfoLog(@"%@", self.error.message);
        return;
    }
    
    NSLog(@"Data available!");
    
    //----- open the read stream and check for errors calling delegate methods
    //----- if things fail. This encapsulates the streamInfo object and cleans up our code.
    [self.streamInfo openRead: self];
//    [self stream:self.streamInfo handleEvent:[];
}



//-----
//
//				stream
//
// synopsis:	[self stream:theStream handleEvent:streamEvent];
//					NSStream *theStream      	-
//					NSStreamEvent streamEvent	-
//
// description:	stream is designed to
//
// errors:		none
//
// returns:		none
//

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
   
    NSLog(@"The stream method is invoked.");
    NSLog(@"Stream delgate is %@", theStream.delegate);
    NSLog(@"Delgate is: %@\n",self.delegate);
    //----- see if we have cancelled the runloop
    if ([self.streamInfo checkCancelRequest: self])
        return;
    
    switch (streamEvent) 
    {
        case NSStreamEventOpenCompleted: 
        {
            NSLog(@"the stream case: NSStreamEventOpenCompleted");
            NSLog(@"Delgate is: %@\n",self.delegate);
            self.maximumSize = [[theStream propertyForKey:(id)kCFStreamPropertyFTPResourceSize] integerValue];
            
            self.didOpenStream = YES;
            self.streamInfo.bytesTotal = 0;
            self.receivedData = [NSMutableData data];
        } 
        break;
            
        case NSStreamEventHasBytesAvailable: 
        {
            
            NSLog(@"the stream case: NSStreamEventHasBytesAvailable");
            NSLog(@"Delgate is: %@\n",self.delegate);
            self.receivedData = [self.streamInfo read: self];
            
            if (self.receivedData)
            {
                [self.delegate requestDataAvailable: self];
            }
            
            else
            {
                
                InfoLog(@"Stream opened, but failed while trying to read from it.");
                [self.streamInfo streamError: self errorCode: kBRFTPClientCantReadStream];
            }
        } 
        break;
            
        case NSStreamEventHasSpaceAvailable: 
        {
            NSLog(@"the stream case: NSStreamEventHasSpaceAvailable");
            NSLog(@"Delgate is: %@\n",self.delegate);
        } 
        break;
            
        case NSStreamEventErrorOccurred: 
        {
            NSLog(@"the stream case: NSStreamEventErrorOccurred");
            NSLog(@"Delgate is: %@\n",self.delegate);
            [self.streamInfo streamError: self errorCode: [BRRequestError errorCodeWithError: [theStream streamError]]];
            InfoLog(@"%@", self.error.message);
        }
        break;
            
        case NSStreamEventEndEncountered: 
        {
             NSLog(@"the stream case: NSStreamEventEndEncountered");
            NSLog(@"Delgate is: %@\n",self.delegate);
            [self.streamInfo streamComplete: self];
        }
        break;

        default:
            break;
    }
}





//-----
//
//				fullRemotePath
//
// synopsis:	retval = [self fullRemotePath];
//					NSString *retval	-
//
// description:	fullRemotePath is designed to
//
// errors:		none
//
// returns:		Variable of type NSString *
//

- (NSString *)fullRemotePath
{
    NSLog(@"Full remote path is invoked!");
    return [self.hostname stringByAppendingPathComponent:self.path];
}

@end
