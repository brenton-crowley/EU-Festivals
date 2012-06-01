//
//  SearchScope.h
//  EuroFestival
//
//  Created by Brenton Crowley on 31/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchScope : NSObject

FOUNDATION_EXPORT NSString *const TITLE_ALL;
FOUNDATION_EXPORT NSString *const TITLE_COUNTRY;
FOUNDATION_EXPORT NSString *const TITLE_DATE;
FOUNDATION_EXPORT NSString *const TITLE_PRICE;

+(id)searchScopeWithTitle:(NSString *)title 
          placeholderText:(NSString *)placeholderText
           sortDescriptor:(NSSortDescriptor *)sortDescriptor;

+(NSArray *)scopes;

+(NSComparisonResult)priceComparison:(NSNumber *)festivalPrice searchComparator:(NSInteger)comparator;
+(NSComparisonResult)countryComparison:(NSString *)countryName searchComparator:(NSString *)comparator;
+(NSComparisonResult)dateComparison:(NSDate *)date searchComparator:(NSString *)comparator;
+(NSComparisonResult)festivalNameComparison:(NSString *)festivalName searchComparator:(NSString *)comparator;
+(NSComparisonResult)bandComparison:(NSString *)bandName searchComparator:(NSString *)comparator;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTextLabel;
@property (nonatomic, strong) NSString *placeholderText;
@property (nonatomic, strong) NSSortDescriptor *sortDescriptor;

@end
