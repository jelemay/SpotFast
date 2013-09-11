//
//  PhotoCache.h
//  SpotFast
//
//  Created by John Lemay on 8/13/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoCache : NSObject



-(BOOL) cacheFileSystemExists;

- (void) addFile:(NSURL *) file;

- (void) deletOldestFile;

- (int) cacheSize;

- (BOOL) fileExist:(NSURL *) file;

-(NSData *) getFile:(NSURL *) file;

@end
