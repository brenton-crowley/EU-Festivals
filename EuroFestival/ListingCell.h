//
//  ListingCell.h
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Festival.h"
#import "Country.h"

@interface ListingCell : UITableViewCell <UISearchBarDelegate>

- (void)styleCellForFestival:(Festival *)festival;

@property (weak, nonatomic) IBOutlet UILabel *festivalDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *festivalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *festivalLineupLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagView;
@property (weak, nonatomic) IBOutlet UILabel *festivalPriceLabel;

@end
