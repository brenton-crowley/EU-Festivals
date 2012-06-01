//
//  SearchCell.h
//  EuroFestival
//
//  Created by Brenton Crowley on 31/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Festival.h"
#import "Country.h"
#import "ListingTableViewController.h"

@interface SearchCell : UITableViewCell

-(void)styleCellForFestival:(Festival *)festival withDetailText:(NSString *)detailText;

@end
