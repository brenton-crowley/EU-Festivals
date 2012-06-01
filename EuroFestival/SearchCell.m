//
//  SearchCell.m
//  EuroFestival
//
//  Created by Brenton Crowley on 31/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)styleCellForFestival:(Festival *)festival withDetailText:(NSString *)detailText {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.font = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:@"Chalkduster"] lastObject] size:15];
    self.detailTextLabel.font = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:@"Chalkduster"] lastObject] size:11];
    self.textLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];

    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"short-cell-bg"]];
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list-accessory-view"]];

    self.textLabel.text = festival.festivalName;
    self.detailTextLabel.text = detailText;

}

@end
