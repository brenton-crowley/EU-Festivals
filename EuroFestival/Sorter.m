//
//  Sorter.m
//  EuroFestival
//
//  Created by Brenton Crowley on 26/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Sorter.h"

@implementation Sorter

@synthesize sortDescriptors = _sortDescriptors;
@synthesize labelText = _labelText;
@synthesize entityName = _entityName;
@synthesize sectionKey = _sectionKey;

+ (id)sorterWithLabelText:(NSString *)labelText 
               entityName:(NSString *)entityName  
           sortDescriptors:(NSArray *)sortDescriptors
               sectionKey:(NSString *)sectionKey{
    
    Sorter *sorter = [[Sorter alloc] init];
    sorter.labelText = labelText;
    sorter.entityName = entityName;
    sorter.sortDescriptors = sortDescriptors;
    sorter.sectionKey = sectionKey;
    
    return sorter;
}

- (NSString *)stringForLabel {
    return self.labelText;
}

+(NSArray *)sorters {
    static NSString *entityName = @"Festival";
    
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"festivalDate" ascending:YES];
    
    NSArray *sorters = [NSArray arrayWithObjects:
                        
                        [Sorter sorterWithLabelText:@"Date Ascending"
                                         entityName:entityName  
                                     sortDescriptors:[NSArray arrayWithObject:dateSortDescriptor] 
                                         sectionKey:nil],
                        
                        [Sorter sorterWithLabelText:@"Date Descending"
                                         entityName:entityName  
                                     sortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"festivalDate" ascending:NO]]
                                         sectionKey:nil],
                        
                        [Sorter sorterWithLabelText:@"Price Ascending"
                                         entityName:entityName  
                                     sortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"festivalPrice" ascending:YES]]
                                         sectionKey:nil],
                        
                        [Sorter sorterWithLabelText:@"Price Descending"
                                         entityName:entityName  
                                     sortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"festivalPrice" ascending:NO]]
                                         sectionKey:nil],
                        
                        [Sorter sorterWithLabelText:@"Country"
                                         entityName:entityName  
                                     sortDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"countryName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)], dateSortDescriptor,nil]
                                         sectionKey:nil],
                        nil];
    return sorters;
}

@end




