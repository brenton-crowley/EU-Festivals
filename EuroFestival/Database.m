//
//  Database.m
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Database.h"

@implementation Database

#define DOCUMENT_NAME @"festival-listing"

+ (void) openDatabaseWithCompletionBlock:(completion_block_t)completionBlock {
    
      NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    
    url = [url URLByAppendingPathComponent:DOCUMENT_NAME];
    UIManagedDocument *fileDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[fileDatabase.fileURL path]]) {
        [fileDatabase saveToURL:fileDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            NSLog(@"Does not exist so create it");
            completionBlock(fileDatabase);
        }];
    }else if (fileDatabase.documentState == UIDocumentStateClosed) {
        [fileDatabase openWithCompletionHandler:^(BOOL success) {
            NSLog(@"Exists so open it");
            completionBlock(fileDatabase);    
        }];
    } else if (fileDatabase.documentState == UIDocumentStateNormal) {
        NSLog(@"Already Open and ready to use");
        completionBlock(fileDatabase);
    }    
}

+ (void) saveDatabase:(UIManagedDocument *)database usingCompletionBlock:(completion_block_t)completionBlock {
    [database saveToURL:database.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        NSLog(@"Saved: %@", success ? @"YES" : @"NO");
        if(completionBlock) completionBlock(database);
    }];
}

@end
