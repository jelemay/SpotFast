//
//  SpotRecentVCSubclass.m
//  Spot
//
//  Created by John Lemay on 7/20/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "SpotRecentVCSubclass.h"
#import "FlickrFetcher.h"

@interface SpotRecentVCSubclass ()

@end

@implementation SpotRecentVCSubclass



- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.photos = [FlickrFetcher latestGeoreferencedPhotos];
    //self.photos = [FlickrFetcher stanfordPhotos];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.photos= [NSArray arrayWithArray:[defaults arrayForKey:@"recentPhotoArray"]];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.photos= [NSArray arrayWithArray:[defaults arrayForKey:@"recentPhotoArray"]];
}


@end
