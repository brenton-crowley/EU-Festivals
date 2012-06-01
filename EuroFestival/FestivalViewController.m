//
//  FestivalViewController.m
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "FestivalViewController.h"

@interface FestivalViewController ()

@end

@implementation FestivalViewController

@synthesize festival = _festival;
@synthesize queriedString = _queriedString;
@synthesize festivalDateLabel = _festivalDateLabel;
@synthesize festivalNameLabel = _festivalNameLabel;
@synthesize festivalLineupTextView = _festivalLineupTextView;
@synthesize delegate = _delegate;
@synthesize managedObjectContext = _managedObjectContext;

#define GOOGLE_URL_PREFIX @"http://www.google.com/search?btnI=I'm+Feeling+Lucky&q="

#pragma mark - Favourite Methods

- (void)onFavouriteButtonPress:(UIBarButtonItem *)sender {
    
    [self.festival setIsFavourited:[NSNumber numberWithBool:!self.festival.isFavourited.boolValue]];
    
    [self validateFavourite];
    
    [self.managedObjectContext save:nil];
    [self.delegate saveFestivalContext];
    
}

- (void)validateFavourite {
    
    self.navigationItem.rightBarButtonItem.image = [self starImageValidation];
}

- (UIImage *)starImageValidation {
    return self.festival.isFavourited.boolValue ? [UIImage imageNamed:@"favourite-icon"] : [UIImage imageNamed:@"favourite-icon-unchecked"];
}

#pragma mark - Setup Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.festivalNameLabel.text = self.festival.festivalName;
    self.festivalLineupTextView.text = self.festival.festivalLineup;
    self.title = _festival.country.countryName;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.festivalDateLabel.text = [NSString stringWithFormat:@"%@ — €%@", [dateFormatter stringFromDate:self.festival.festivalDate], self.festival.festivalPrice];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[self starImageValidation] style:UIBarButtonItemStyleBordered target:self action:@selector(onFavouriteButtonPress:)];
    
    [self validateFavourite];
}

- (void)viewDidUnload
{
    [self setFestivalDateLabel:nil];
    [self setFestivalNameLabel:nil];
    [self setFestivalLineupTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - URL Button Press TargetAction

- (IBAction)onURLPress:(UIButton *)sender {
    
    NSString *festivalQuery = [NSString stringWithFormat:@"%@+%@", self.festival.festivalName, self.festival.countryName];
    NSString *encodedString = [NSString stringWithFormat:@"%@%@", GOOGLE_URL_PREFIX, [festivalQuery stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSURL *url = [NSURL URLWithString:encodedString];
    if (![[UIApplication sharedApplication] openURL:url])
    NSLog(@"%@%@",@"Failed to open url:",[url description]);
}

@end
