//
//  ListingCell.m
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "ListingCell.h"

@implementation ListingCell

@synthesize festivalDateLabel = _festivalDateLabel;
@synthesize festivalNameLabel = _festivalNameLabel;
@synthesize festivalLineupLabel = _festivalLineupLabel;
@synthesize flagView = _flagView;
@synthesize festivalPriceLabel = _festivalPriceLabel;

- (void)styleCellForFestival:(Festival *)festival {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-item-bg"]];
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-accessory-view"]];
    
    NSString *festivalPrice = [NSString stringWithFormat:@"€%@", festival.festivalPrice.integerValue != 0 ? festival.festivalPrice : ([festival.festivalLineup isEqualToString:@"TBA"] ? @"TBC" : @"FREE!")];
    
    self.festivalNameLabel.text = festival.festivalName;
    self.festivalDateLabel.text = [dateFormatter stringFromDate:festival.festivalDate];
//    self.festivalPriceLabel.text = [NSString stringWithFormat:@"€%@", festival.festivalPrice];
    self.festivalPriceLabel.text = festivalPrice;
    self.festivalLineupLabel.text = festival.festivalLineup;
    self.flagView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", festival.country.flagURL]];
    
}

@end
