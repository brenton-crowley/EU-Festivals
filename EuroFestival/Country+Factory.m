//
//  Country+Factory.m
//  EuroFestival
//
//  Created by Brenton Crowley on 24/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Country+Factory.h"

@implementation Country (Factory)

#define ENTITY_NAME NSStringFromClass([Country class])

+ (Country *) addCountry:(NSDictionary *)countryFromFile countryKey:(NSString *)countryKey inContext:(NSManagedObjectContext *)context {
    
    Country *country = nil;
    
    NSString *countryName = [countryFromFile objectForKey:@"countryName"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"countryName = %@", countryName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"countryName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        NSLog(@"Error Fetching the country in the database");
    } else if ([matches count] == 0) {
        country = [Country createCountryFromCountryInFile:countryFromFile countryKey:countryKey inContext:context];
        NSLog(@"Add the country to the database. Country Added: %@", country.countryName);
        
    } else {
        country = [matches lastObject];
        NSLog(@"Country already exists in the database. Country: %@", country.countryName);
    }
    
    return country;
    
}

+ (Country *) createCountryFromCountryInFile:(NSDictionary *)countryFromFile countryKey:(NSString *)countryKey inContext:(NSManagedObjectContext *)context {
    
    NSString *countryName = [countryFromFile objectForKey:@"countryName"];
    
    Country *country = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    country.countryName = countryName;
    country.flagURL = countryKey;
    
    return country;
}

- (void)addAllFestivalsFromFile:(NSArray *)festivalsFromFile {

        for (int i = 0; i < festivalsFromFile.count; i++) {
            NSDictionary *rawFestival = [festivalsFromFile objectAtIndex:i];
            NSString *countryName = self.countryName;
            NSLog(@"Country Name: %@", countryName);
            Festival *festival = [Festival addFestival:rawFestival forCountry:countryName inContext:self.managedObjectContext];
            festival.country = self;
            festival.countryName = self.countryName;
        }
}

@end
