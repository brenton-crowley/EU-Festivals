//
//  Country.h
//  EuroFestival
//
//  Created by Brenton Crowley on 24/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Festival;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * flagURL;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSSet *festivals;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addFestivalsObject:(Festival *)value;
- (void)removeFestivalsObject:(Festival *)value;
- (void)addFestivals:(NSSet *)values;
- (void)removeFestivals:(NSSet *)values;

@end
