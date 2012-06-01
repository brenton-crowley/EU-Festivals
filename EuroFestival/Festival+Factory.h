//
//  Festival+Factory.h
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Festival.h"

@interface Festival (Factory)

+ (Festival *) addFestival:(NSDictionary *)festivalFromFile forCountry:(NSString *)countryName inContext:(NSManagedObjectContext *)context;

@end
