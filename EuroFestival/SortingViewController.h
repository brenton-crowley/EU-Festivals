//
//  SortingViewController.h
//  EuroFestival
//
//  Created by Brenton Crowley on 26/05/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortingViewControllerContentObject <NSObject>

- (NSString *)stringForLabel;

@end

@protocol SortingViewControllerDelegate <NSObject>

- (void)selectionCompleteWithObject:(id <SortingViewControllerContentObject>)object;

@end

@interface SortingViewController : UITableViewController

@property (nonatomic, strong) NSArray *externalSections;
@property (nonatomic, strong) id <SortingViewControllerContentObject> sortingObject;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) id <SortingViewControllerDelegate> delegate;

@end
