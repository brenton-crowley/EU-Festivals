//
//  Festival+Factory.m
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Festival+Factory.h"

@implementation Festival (Factory)

#define ENTITY_NAME @"Festival"

+ (Festival *) addFestival:(NSDictionary *)festivalFromFile forCountry:(NSString *)countryName inContext:(NSManagedObjectContext *)context {
    
    Festival *festival = nil;
    
    NSString *festivalName = [festivalFromFile objectForKey:@"festivalName"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"festivalName = %@", festivalName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"festivalDate" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        NSLog(@"Error Fetching the festival in the database");
    } else if ([matches count] == 0) {
        festival = [Festival createFestivalFromFestivalInFile:festivalFromFile inCountry:countryName inContext:context];
        NSLog(@"We need to add the festival to the database. Festival Added: %@", festival.festivalName);
        
    } else {
        festival = [matches lastObject];
        NSLog(@"Festival already exists in the database. Festival: %@", festival.festivalName);
    }
    
    return festival;
    
}

+ (Festival *) createFestivalFromFestivalInFile:(NSDictionary *)festivalFromFile inCountry:(NSString *)countryName inContext:(NSManagedObjectContext *)context {
    
    NSString *festivalName = [festivalFromFile objectForKey:@"festivalName"];
    NSString *festivalLocation = countryName;
    NSString *festivalLineup = [festivalFromFile objectForKey:@"festivalLineup"];
    NSNumber *festivalPrice = [festivalFromFile objectForKey:@"festivalPrice"];
    NSDate *festivalDate = [festivalFromFile objectForKey:@"festivalDate"];
    
    Festival *festival = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    festival.festivalName = festivalName;
    festival.festivalLineup = festivalLineup;
    festival.festivalPrice = festivalPrice;
    festival.festivalLocation = festivalLocation;
    festival.festivalDate = festivalDate;
    festival.isFavourited = [NSNumber numberWithBool:NO];
    
    return festival;
}

@end
