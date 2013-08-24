//
//  SpotSecondViewController.h
//  Spot
//
//  Created by John Lemay on 7/17/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotRecentViewController : UITableViewController

// the Model for this VC
// an array of dictionaries of Flickr information
// obtained using Flickr API
// (e.g. FlickrFetcher will obtain such an array of dictionaries)
@property (nonatomic, strong) NSArray *photos; // of NSDictionary


@end
