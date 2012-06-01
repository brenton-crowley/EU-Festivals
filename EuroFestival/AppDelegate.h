//
//  AppDelegate.h
//  EuroFestival
//
//  Created by Brenton Crowley on 21/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country+Factory.h"
#import "ListingTableViewController.h"
#import "Database.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
