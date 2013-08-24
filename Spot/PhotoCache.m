//
//  PhotoCache.m
//  SpotFast
//
//  Created by John Lemay on 8/13/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "PhotoCache.h"

@implementation PhotoCache




-(void) createFilesystem

{
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * home = NSHomeDirectory();
     NSLog(@"home directory NSString   %@",home);
    NSString * cacheDirectory = [home stringByAppendingString:@"/Library/Caches" ];
    NSLog(@"cache directory %@" ,cacheDirectory);
    BOOL  dirFound =[manager fileExistsAtPath: cacheDirectory];
    if(dirFound  == YES){
            NSLog(@"directory found");
    }
    else{
          NSLog(@"directory not found ");
    }
    NSArray * cacheContents=[manager contentsOfDirectoryAtPath:cacheDirectory error:nil];
    NSLog(@"cache directory size %d" ,[cacheContents count]);
    
      NSString * photoCache = [home stringByAppendingString:@"/Library/Caches/PhotoCache/" ];
    BOOL directoryCreated = [manager createDirectoryAtPath:photoCache withIntermediateDirectories:NO attributes:nil error:nil];
    
    if(directoryCreated  == YES){
        NSLog(@" phot directory created");
    }
    else{
        NSLog(@" photo directory not created ");
    }
    
    
    
    
    NSArray * photoCacheContents=[manager contentsOfDirectoryAtPath:photoCache error:nil];
    NSLog(@"photoCache directory size %d" ,[photoCacheContents count]);

}
-(BOOL)fileSystemExists
{
    return true;
};

- (void) addFile:(NSURL *) file
{
    
};

- (void) deletOldestFile
{
    
};

- (BOOL) fileExist:(NSURL *) file
{
    return true;
};

-(NSData *) getFile:(NSURL *) file
{
    return nil;
};

@end