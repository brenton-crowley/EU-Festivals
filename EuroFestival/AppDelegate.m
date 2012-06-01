//
//  AppDelegate.m
//  EuroFestival
//
//  Created by Brenton Crowley on 21/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark -
#pragma mark Application Launch

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self customiseNavigationBar];
    [self customiseSearchBar];
    [self customiseSegmentedControl];
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    ListingTableViewController *rootViewController = (ListingTableViewController *)[[navigationController viewControllers] objectAtIndex:0];
    rootViewController.managedObjectContext = self.managedObjectContext;
    
//    [Database openDatabaseWithCompletionBlock:^(UIManagedDocument *database) {
//        [self initialiseFestivalsFromFile:database];
//        [Database saveDatabase:database usingCompletionBlock:^(UIManagedDocument *database) {}];
//    }];
    
    return YES;
}

#pragma mark -
#pragma mark Object Model, Context and Store Setup

- (NSManagedObjectContext *) managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) return _persistentStoreCoordinator;
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"festival-listing"];
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:[storeURL path]]) {
        NSLog(@"Cannot Locate Store in Documents");
        NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"Festivals" withExtension:@"CDBStore"];

        if (defaultStoreURL) {
            NSLog(@"Default Store Exists");
            [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
        }
    }
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {abort();}

    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Database" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark -
#pragma mark UI Customisation

- (void)customiseNavigationBar {
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-bg"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Chalkduster" size:0.0], UITextAttributeFont, nil]];
    
    // Bar button Item
    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30"] 
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"] 
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsLandscapePhone];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Chalkduster" size:0.0], UITextAttributeFont, nil] 
                                                forState:UIControlStateNormal];
    
    // Back Button
    UIImage *buttonBack30 = [[UIImage imageNamed:@"button_back_textured_30"] 
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}

- (void)customiseSearchBar {
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"short-cell-bg"]];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"search-field-bg"] forState:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search-icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [[UISearchBar appearance] setScopeBarBackgroundImage:[UIImage imageNamed:@"short-cell-bg"]];
}

// Also handles SearchScopeBar Segements
- (void)customiseSegmentedControl {
    
    UIImage *segmentSelected = [[UIImage imageNamed:@"segcontrol_sel"] 
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"segcontrol_uns"] 
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"segcontrol_sel-uns"];
    UIImage *segUnselectedSelected = [UIImage imageNamed:@"segcontrol_uns-sel"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"segcontrol_uns-uns"];
    
    // Unselected State
    [[UISearchBar appearance] setScopeBarButtonBackgroundImage:segmentUnselected forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected 
                                               forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // Selected State
    [[UISearchBar appearance] setScopeBarButtonBackgroundImage:segmentSelected forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected 
                                               forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    // Divided Left Normal Right Normal
    [[UISearchBar appearance] setScopeBarButtonDividerImage:segmentUnselectedUnselected forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected 
                                 forLeftSegmentState:UIControlStateNormal 
                                   rightSegmentState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    // Divided Left Selected Right Normal
    [[UISearchBar appearance] setScopeBarButtonDividerImage:segmentSelectedUnselected forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected 
                                 forLeftSegmentState:UIControlStateSelected 
                                   rightSegmentState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    // Divided Left Normal Right Selected
    [[UISearchBar appearance] setScopeBarButtonDividerImage:segUnselectedSelected  forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected];
    [[UISegmentedControl appearance] 
     setDividerImage:segUnselectedSelected 
     forLeftSegmentState:UIControlStateNormal 
     rightSegmentState:UIControlStateSelected 
     barMetrics:UIBarMetricsDefault];
    
    // For the Text
    NSDictionary *textAttributeDictionaryNormal = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont fontWithName:@"Chalkduster" size:0.0], 
                                             UITextAttributeFont, [UIColor grayColor], UITextAttributeTextColor,
                                             nil];
    NSDictionary *textAttributeDictionarySelected = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [UIFont fontWithName:@"Chalkduster" size:0.0], 
                                                   UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor,
                                                   nil];
    [[UISearchBar appearance] setScopeBarButtonTitleTextAttributes:textAttributeDictionaryNormal forState:UIControlStateNormal];
    [[UISearchBar appearance] setScopeBarButtonTitleTextAttributes:textAttributeDictionarySelected forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttributeDictionaryNormal forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:textAttributeDictionarySelected forState:UIControlStateSelected];
    
}

- (void)customiseUITableView {
    
    [UITableView appearance];
    
}

#pragma mark -
#pragma mark Subroutine for initial Core Data Population

//Used to initially create store

- (void) initialiseFestivalsFromFile:(UIManagedDocument *)database {
    NSString *errorDesc = nil;
    NSPropertyListFormat format = 0;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"FestivalListing.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) plistPath = [[NSBundle mainBundle] pathForResource:@"FestivalListing" ofType:@"plist"];
    
    NSDictionary *countriesData = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:plistPath]];
    if (!countriesData) NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    
    NSDictionary *countries = [countriesData objectForKey:@"countries"];
    
    for (id countryKeyInCountries in countries) {
        
        // team parsing
        NSDictionary *rawCountry = [countries objectForKey:countryKeyInCountries];
        
        Country *country = [Country addCountry:rawCountry countryKey:countryKeyInCountries inContext:database.managedObjectContext];
        
        [country addAllFestivalsFromFile:[rawCountry objectForKey:@"festivals"]];
    }
    
}

@end
