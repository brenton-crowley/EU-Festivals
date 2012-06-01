//
//  SearchScope.m
//  EuroFestival
//
//  Created by Brenton Crowley on 31/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "SearchScope.h"

@implementation SearchScope

NSString *const TITLE_ALL = @"All";
NSString *const TITLE_COUNTRY = @"Country";
NSString *const TITLE_DATE = @"Date";
NSString *const TITLE_PRICE = @"Price";

@synthesize title = _title;
@synthesize detailTextLabel = _detailTextLabel;
@synthesize placeholderText = _placeholderText;
@synthesize sortDescriptor = _sortDescriptor;

+(id)searchScopeWithTitle:(NSString *)title 
          placeholderText:(NSString *)placeholderText
           sortDescriptor:(NSSortDescriptor *)sortDescriptor{
    
    SearchScope *searchScope = [[SearchScope alloc] init];
    
    searchScope.title = title;
    searchScope.placeholderText = placeholderText;
    searchScope.sortDescriptor = sortDescriptor;
    
    return searchScope;
}

-(NSSortDescriptor *)sortDescriptor {
    if(!_sortDescriptor) _sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"festivalDate" ascending:NO];
        return _sortDescriptor;
}

+(NSArray *)scopes {
    NSArray *scopes = [NSArray arrayWithObjects:[SearchScope searchScopeWithTitle:TITLE_ALL placeholderText:@"Search a festival or band" sortDescriptor:nil],
                       [SearchScope searchScopeWithTitle:TITLE_COUNTRY placeholderText:@"E.g. Germany" sortDescriptor:nil],
                       [SearchScope searchScopeWithTitle:TITLE_PRICE placeholderText:@"E.g. 150" sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"festivalPrice" ascending:NO]], 
                       [SearchScope searchScopeWithTitle:TITLE_DATE placeholderText:@"E.g. 29-JUL-12" sortDescriptor:nil], nil];
    return scopes;
}

+(NSComparisonResult)priceComparison:(NSNumber *)festivalPrice searchComparator:(NSInteger)comparator {
    NSComparisonResult priceComparison = [festivalPrice compare:[NSNumber numberWithInt:comparator]];
    return priceComparison;
}

+(NSComparisonResult)countryComparison:(NSString *)countryName searchComparator:(NSString *)comparator {
    NSComparisonResult countryComparison = [countryName compare:comparator options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [comparator length])];
    return countryComparison;
}

+(NSComparisonResult)dateComparison:(NSDate *)date searchComparator:(NSString *)comparator {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yy";
    NSComparisonResult dateComparison = [date compare:[dateFormatter dateFromString:comparator]];
    return dateComparison;
}

+(NSComparisonResult)festivalNameComparison:(NSString *)festivalName searchComparator:(NSString *)comparator {
    NSComparisonResult festivalNameResult = [festivalName compare:comparator options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [comparator length])];
    return festivalNameResult;
}

+(NSComparisonResult)bandComparison:(NSString *)bandName searchComparator:(NSString *)comparator {
    NSComparisonResult festivalLineupResult = [bandName compare:comparator options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:[bandName rangeOfString:comparator options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [bandName length])]];
    return festivalLineupResult;
}

@end
