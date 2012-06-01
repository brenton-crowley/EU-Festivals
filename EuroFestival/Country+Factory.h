//
//  Country+Factory.h
//  EuroFestival
//
//  Created by Brenton Crowley on 24/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Country.h"
#import "Festival+Factory.h"

@interface Country (Factory)

+ (Country *) addCountry:(NSDictionary *)countryFromFile countryKey:(NSString *)countryKey inContext:(NSManagedObjectContext *)context;
- (void)addAllFestivalsFromFile:(NSArray *)festivalsFromFile;

@end
