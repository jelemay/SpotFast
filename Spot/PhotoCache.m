//
//  PhotoCache.m
//  SpotFast
//
//  Created by John Lemay on 8/13/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "PhotoCache.h"
@interface PhotoCache()
@property(strong , nonatomic) NSString * cacheDirectory;
@property(strong,nonatomic) NSString * photoCache;
@property (strong ,nonatomic)   NSFileManager * manager;

@end

@implementation PhotoCache

- (id)init{
    self=[super init];
    if(self)
    {
        NSFileManager * manager = [NSFileManager defaultManager];
        NSString * home = NSHomeDirectory();
        NSLog(@"home directory NSString   %@",home);
        _cacheDirectory = [home stringByAppendingString:@"/Library/Caches" ];
        _photoCache = [home stringByAppendingString:@"/Library/Caches/PhotoCache/" ];
        
        BOOL  dirFound =[manager fileExistsAtPath: _cacheDirectory];
        if(dirFound  == YES)
        {
            BOOL directoryCreated = [manager createDirectoryAtPath:_photoCache withIntermediateDirectories:YES attributes:nil error:nil];
            
            if(directoryCreated  == YES){
                NSLog(@" photo directory created");
            }
            else{
                NSLog(@" photo directory not created ");
            }
            
            NSLog(@"directory found");
        }
        else{
            NSLog(@" cache directory not found ");
        }
        
    }
    return self;
}



-(BOOL)cacheFileSystemExists
{
    BOOL  dirFound =[self.manager fileExistsAtPath: self.cacheDirectory];
    if(dirFound  == YES)
    {
    return true;
    }
    return false;
};
- (int) cacheSize
{
    
    NSArray * photoCacheContents=[self.manager contentsOfDirectoryAtPath:self.photoCache error:nil];
    return [photoCacheContents count];
}


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