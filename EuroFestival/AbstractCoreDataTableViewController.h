//
//  AbstractCoreDataTableViewController.h
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AbstractCoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)performFetch;

@property (nonatomic) BOOL suspendAutomaticTrackingOfChangesInManagedObjectContext;
@property BOOL debug;

@end
