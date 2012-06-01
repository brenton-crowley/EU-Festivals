//
//  Festival.h
//  EuroFestival
//
//  Created by Brenton Crowley on 31/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country;

@interface Festival : NSManagedObject

@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSDate * festivalDate;
@property (nonatomic, retain) NSString * festivalLineup;
@property (nonatomic, retain) NSString * festivalLocation;
@property (nonatomic, retain) NSString * festivalName;
@property (nonatomic, retain) NSNumber * festivalPrice;
@property (nonatomic, retain) NSNumber * isFavourited;
@property (nonatomic, retain) Country *country;

@end
