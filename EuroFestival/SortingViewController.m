//
//  SortingViewController.m
//  EuroFestival
//
//  Created by Brenton Crowley on 26/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "SortingViewController.h"

@interface SortingViewController ()

@end

@implementation SortingViewController

@synthesize externalSections = _externalSections;
@synthesize selectedIndex = _selectedIndex;
@synthesize delegate = _delegate;
@synthesize sortingObject = _sortingObject;

#pragma mark - Setup and teardown Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(onDonePressed:)];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-tableview-bg"]];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.25 alpha:1];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.externalSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *externalSection = [self.externalSections objectAtIndex:section];
    return externalSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SortingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *externalSection = [self.externalSections objectAtIndex:indexPath.section];
    id <SortingViewControllerContentObject> objectContent = [externalSection objectAtIndex:indexPath.row];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"short-cell-bg"]];
    cell.textLabel.text = [objectContent stringForLabel];
    
    if([[objectContent stringForLabel] isEqualToString:[self.sortingObject stringForLabel]]) cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-accessory-view-checkmark"]];
    else cell.accessoryView = nil;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.self.sortingObject = [[self.externalSections lastObject] objectAtIndex:indexPath.row];

    [self.tableView reloadData];
}

#pragma mark -
#pragma Done Control

- (void)onDonePressed:(UIBarButtonItem *)sender {
    
    [self.delegate selectionCompleteWithObject:self.sortingObject];
}


@end
