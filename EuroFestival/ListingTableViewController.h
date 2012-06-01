//
//  ListingTableViewController.h
//  EuroFestival
//
//  Created by Brenton Crowley on 21/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCoreDataTableViewController.h"
#import "ListingCell.h"
#import "Festival+Factory.h"
#import "FestivalViewController.h"
#import "Country+Factory.h"
#import "SortingViewController.h"
#import "Sorter.h"
#import "SearchScope.h"
#import "SearchCell.h"

@interface ListingTableViewController : AbstractCoreDataTableViewController <UISearchBarDelegate, UISearchDisplayDelegate, SortingViewControllerDelegate, FestivalViewControllerDelegate>

- (NSString *)searchScopeBasedDetailText:(Festival *)festival;

@property (nonatomic, strong) Festival *festival;
@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic, strong) NSArray *sorters;
@property (nonatomic, strong) Sorter *currentSorter;
@property (nonatomic, strong) SearchScope *currentSearchScope;
@property (nonatomic) BOOL isFavouritesSelected;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
