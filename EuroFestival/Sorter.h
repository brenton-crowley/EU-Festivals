//
//  Sorter.h
//  EuroFestival
//
//  Created by Brenton Crowley on 26/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SortingViewController.h"

@interface Sorter : NSObject <SortingViewControllerContentObject>

+(NSArray *)sorters;

+ (id)sorterWithLabelText:(NSString *)labelText 
               entityName:(NSString *)entityName  
          sortDescriptors:(NSArray *)sortDescriptors
               sectionKey:(NSString *)sectionKey;

@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSString *labelText;
@property (strong, nonatomic) NSString *entityName;
@property (strong, nonatomic) NSString *sectionKey;

@end
