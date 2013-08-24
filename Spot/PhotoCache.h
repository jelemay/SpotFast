//
//  PhotoCache.h
//  SpotFast
//
//  Created by John Lemay on 8/13/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoCache : NSObject

-(void) createFilesystem;

-(BOOL)fileSystemExists;

- (void) addFile:(NSURL *) file;

- (void) deletOldestFile;

- (BOOL) fileExist:(NSURL *) file;

-(NSData *) getFile:(NSURL *) file;

@end
