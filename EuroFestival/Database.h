//
//  Database.h
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Database : NSObject

typedef void (^completion_block_t)(UIManagedDocument *database);

+ (void) openDatabaseWithCompletionBlock:(completion_block_t)completionBlock;
+ (void) saveDatabase:(UIManagedDocument *)database usingCompletionBlock:(completion_block_t)completionBlock;

@end
