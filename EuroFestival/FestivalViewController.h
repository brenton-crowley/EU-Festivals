//
//  FestivalViewController.h
//  EuroFestival
//
//  Created by Brenton Crowley on 23/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Festival+Factory.h"
#import "Country+Factory.h"

@protocol FestivalViewControllerDelegate <NSObject>

- (void)saveFestivalContext;

@end

@interface FestivalViewController : UIViewController

@property (nonatomic, strong) Festival *festival;
@property (nonatomic, strong) NSString *queriedString;

@property (weak, nonatomic) IBOutlet UILabel *festivalDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *festivalNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *festivalLineupTextView;
@property (strong, nonatomic) id <FestivalViewControllerDelegate> delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
