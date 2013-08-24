//
//  FeatureCategoryVC.h
//  Spot
//
//  Created by John Lemay on 7/21/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureCategoryVC : UITableViewController

// the base Model for the application
// an array of dictionaries of Flickr information
// obtained using Flickr API
// (e.g. FlickrFetcher will obtain such an array of dictionaries)
@property (nonatomic, strong) NSArray *photos; // of NSDictionary

// the model for this VC, aggregated images into classes
// an array of dictionsaries
//each dictionary contains neta data and an array of dictionsaries
@property (nonatomic, strong) NSMutableArray *photoCategories;

@end
