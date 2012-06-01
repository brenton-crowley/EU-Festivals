//
//  ListingTableViewController.m
//  EuroFestival
//
//  Created by Brenton Crowley on 21/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "ListingTableViewController.h"

@interface ListingTableViewController ()

@end

@implementation ListingTableViewController

@synthesize festival = _festival;
@synthesize filteredListContent = _filteredListContent;
@synthesize sorters = _sorters;
@synthesize currentSorter = _currentSorter;
@synthesize currentSearchScope = _currentSearchScope;
@synthesize isFavouritesSelected = _isFavouritesSelected;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark -
#pragma mark - Setup Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-tableview-bg"]];
    
    [self initSearchDisplayController];
    
    [self fetchFestivals];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)initSearchDisplayController {
    
    // set the background image and separator colour of the search tableview
    self.searchDisplayController.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-tableview-bg"]];
    self.searchDisplayController.searchResultsTableView.separatorColor = [UIColor colorWithWhite:0.25 alpha:1];
    
    // set scope titles
    NSMutableArray *scopeTitles = [[NSMutableArray alloc] init];
    for (int i = 0; i < [[SearchScope scopes] count]; i++) {
        SearchScope *searchScope = [[SearchScope scopes] objectAtIndex:i];
        [scopeTitles addObject:searchScope.title];
    }
    self.searchDisplayController.searchBar.scopeButtonTitles = scopeTitles;
    
    // set the colour of the text in the search textfield.
    for (UIView *view in self.searchDisplayController.searchBar.subviews) {
        if([view isKindOfClass:[UITextField class]]){
            UITextField *textfield = (UITextField *)view;
            [textfield setTextColor:[UIColor lightTextColor]];
        }
    }
}

#pragma mark -
#pragma mark Sorters

//Look inside sorters for more detail of the sort options
- (NSArray *)sorters {
    _sorters = [Sorter sorters];
    return _sorters;
}

- (Sorter *)currentSorter {
    if(!_currentSorter) _currentSorter = [self.sorters objectAtIndex:0];
    return _currentSorter;
}

#pragma mark -
#pragma mark - FetchResults

- (void)fetchFestivals{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Festival class])];
    
    request.sortDescriptors = self.currentSorter.sortDescriptors;
    if(self.isFavouritesSelected) request.predicate = [NSPredicate predicateWithFormat:@"isFavourited = 1"];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:self.currentSorter.sectionKey
                                                                                   cacheName:nil];
    
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects]];
    
}

#pragma mark - 
#pragma mark TableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.searchDisplayController.searchResultsTableView) return [self.filteredListContent count];
	else return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
	Festival *festival = nil;
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        festival = [self.filteredListContent objectAtIndex:indexPath.row];
        
        static NSString *kCellID = @"SearchCell";
        
        SearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:kCellID];
        if (searchCell == nil) {
            searchCell = [[SearchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID];
            searchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        [searchCell styleCellForFestival:festival withDetailText:[self searchScopeBasedDetailText:festival]];
        
        cell = searchCell;

    }else {
        festival = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        static NSString *CellIdentifier = @"ListingCell";
        ListingCell *listingCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [listingCell styleCellForFestival:festival];
        
        cell = listingCell;
    }
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        self.festival = [self.filteredListContent objectAtIndex:indexPath.row];
    }else{
        self.festival = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    [self performSegueWithIdentifier:@"FestivalSegue" sender:self];
}

#pragma mark - 
#pragma mark Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.destinationViewController respondsToSelector:@selector(setFestival:)]){
        [segue.destinationViewController performSelector:@selector(setFestival:) withObject:self.festival];
    }
    
    if([segue.destinationViewController respondsToSelector:@selector(setQueriedString:)]){
        [segue.destinationViewController performSelector:@selector(setQueriedString:) withObject:self.searchDisplayController.searchBar.text];
    }
    
    if([segue.destinationViewController respondsToSelector:@selector(setExternalSections:)]){
        [segue.destinationViewController performSelector:@selector(setExternalSections:) withObject:[NSArray arrayWithObject:self.sorters]];
    }
    
    if([segue.destinationViewController respondsToSelector:@selector(setSortingObject:)]){
        [segue.destinationViewController performSelector:@selector(setSortingObject:) withObject:self.currentSorter];
    }
    
    if([segue.destinationViewController respondsToSelector:@selector(setDelegate:)]){
        [segue.destinationViewController performSelector:@selector(setDelegate:) withObject:self];
    }
    
    if([segue.destinationViewController respondsToSelector:@selector(setManagedObjectContext:)]){
        [segue.destinationViewController performSelector:@selector(setManagedObjectContext:) withObject:self.managedObjectContext];
    }
    
}

#pragma mark -
#pragma mark Content Filtering, Search Scope and Favourites

-(SearchScope *)currentSearchScope {
    _currentSearchScope = [[SearchScope scopes] objectAtIndex:self.searchDisplayController.searchBar.selectedScopeButtonIndex];
    if(!_currentSearchScope) _currentSearchScope = [[SearchScope scopes] objectAtIndex:0];
    return _currentSearchScope;
}

- (void)filterContentForSearchText:(NSString*)searchText {
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
	for (Festival *festival in [self.fetchedResultsController fetchedObjects])	{
        
        // Define all the comparison results. Makes it cleaner to compare in if statements with the scope filter
        NSComparisonResult priceComparison = [SearchScope priceComparison:festival.festivalPrice searchComparator:[searchText integerValue]];
		NSComparisonResult countryComparison = [SearchScope countryComparison:festival.countryName searchComparator:searchText];
        NSComparisonResult dateComparison = [SearchScope dateComparison:festival.festivalDate searchComparator:searchText];
        NSComparisonResult festivalNameResult = [SearchScope festivalNameComparison:festival.festivalName searchComparator:searchText];
        NSComparisonResult festivalLineupResult = [SearchScope bandComparison:festival.festivalLineup searchComparator:searchText];
        
        // Filter in all the relevant objects.
        if ([self.currentSearchScope.title isEqualToString:TITLE_ALL]) {
            if (festivalNameResult == NSOrderedSame || 
                festivalLineupResult == NSOrderedSame) [self.filteredListContent addObject:festival];
        }else if ([self.currentSearchScope.title isEqualToString:TITLE_COUNTRY]) {
            if(countryComparison == NSOrderedSame) [self.filteredListContent addObject:festival];
        }else if ([self.currentSearchScope.title isEqualToString:TITLE_DATE]) {
            if(dateComparison == NSOrderedAscending) [self.filteredListContent addObject:festival];
        }else if ([self.currentSearchScope.title isEqualToString:TITLE_PRICE]) {
            if(priceComparison == NSOrderedAscending) [self.filteredListContent addObject:festival];
        }
	}
}

- (NSString *)searchScopeBasedDetailText:(Festival *)festival {
    NSString *detailText = festival.countryName;
    
    if ([self.currentSearchScope.title isEqualToString:TITLE_DATE]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        detailText = [dateFormatter stringFromDate:festival.festivalDate];
    }else if ([self.currentSearchScope.title isEqualToString:TITLE_PRICE]) {
        detailText = [NSString stringWithFormat:@"€%@", festival.festivalPrice];
        
    }
    
    return detailText;
}

-(BOOL)isFavouritesSelected {
    if(!_isFavouritesSelected) _isFavouritesSelected = NO;
    return _isFavouritesSelected;
}

-(NSMutableArray *)filteredListContent {
    if(_filteredListContent.count != 0) [_filteredListContent sortUsingDescriptors:[NSArray arrayWithObject:self.currentSearchScope.sortDescriptor]];
    return _filteredListContent;
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    self.searchDisplayController.searchBar.placeholder = self.currentSearchScope.placeholderText;
}

#pragma mark -
#pragma mark Navigation Bar Controls

- (IBAction)onSortPress:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"SortingSegue" sender:self];
}

- (IBAction)onSearchPress:(UIBarButtonItem *)sender {
    [self.searchDisplayController setActive:YES];
    [self.searchDisplayController.searchBar becomeFirstResponder];
}

#pragma mark -
#pragma mark Segmented Control

- (IBAction)onSegmentedControlValueChange:(UISegmentedControl *)sender {
    
    self.isFavouritesSelected = sender.selectedSegmentIndex == 0 ? NO : YES;

    [self fetchFestivals];
    
}

#pragma mark -
#pragma mark Sorter Delegate Methods

- (void)selectionCompleteWithObject:(id<SortingViewControllerContentObject>)object {
    self.currentSorter = object;
    
    [self fetchFestivals];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark FestivalViewController Delegate Methods

- (void)saveFestivalContext {
//    [Database saveDatabase:self.database usingCompletionBlock:^(UIManagedDocument *database) {}];
    [self.managedObjectContext save:nil];
}

@end
