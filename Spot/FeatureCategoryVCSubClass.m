//
//  FeatureCategoryVCSubClass.m
//  Spot
//
//  Created by John Lemay on 7/21/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "FeatureCategoryVCSubClass.h"
#import "FlickrFetcher.h"

@interface FeatureCategoryVCSubClass ()

@end

@implementation FeatureCategoryVCSubClass



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
        //self.photos = [FlickrFetcher latestGeoreferencedPhotos];
        self.photos = [FlickrFetcher stanfordPhotos];
   
   [self createPhotoCategories];
    }
- (void) createPhotoCategories
{
    NSMutableArray * myArrayPhotos=[[NSMutableArray alloc]init];
    NSDictionary * item;
    
    for ( item in self.photos)
    {
       
        [myArrayPhotos addObject:(NSDictionary *)item ];
        NSString * firstWord= [[item objectForKey:@"tags"] componentsSeparatedByString:@" "] [0];
        NSString * firstWordCapitalized= [firstWord capitalizedString];
        [self addToCategories:firstWordCapitalized itemDictionary:item];
               
    }

   // NSLog(@"  photoCategories count %d", self.photoCategories.count);
   // NSLog(@" photoCategories array %@", self.photoCategories);
}

- (void) addToCategories:(NSString *)firstWordCapitalized itemDictionary:(NSDictionary *)item
{
    if (![self categoryExists:firstWordCapitalized] )
    {
        NSMutableDictionary * newCategoryDictionary = [[NSMutableDictionary alloc]init];
        NSMutableArray * categoryPhotoArray = [[NSMutableArray alloc]init];
        [newCategoryDictionary setObject:firstWordCapitalized forKey:@"categoryTag"];
        [newCategoryDictionary setObject:categoryPhotoArray forKey:@"categoryPhotoArray"];
        [[newCategoryDictionary objectForKey:@"categoryPhotoArray"] addObject:item];
        [self.photoCategories addObject:newCategoryDictionary];

    }
    else
    {
          
        NSMutableDictionary *  dictionaryItem ;
        
        for(dictionaryItem in self.photoCategories)
        {
            NSString * itemCategoryTag= [dictionaryItem objectForKey:@"categoryTag"];
            BOOL match= [itemCategoryTag isEqualToString:firstWordCapitalized];
            if(match)
            {
               [[dictionaryItem objectForKey:@"categoryPhotoArray"] addObject:item];
            //     NSLog(@" photoCategories array %@", self.photoCategories);
            }
        }
        
        
        
    }
}
-(Boolean) categoryExists:(NSString *)firstWordCapitalized
{
    NSMutableDictionary *  dictionaryItem ;
    for(dictionaryItem in self.photoCategories)
    {  
        NSString * itemCategoryTag= [dictionaryItem objectForKey:@"categoryTag"];
        BOOL match= [itemCategoryTag isEqualToString:firstWordCapitalized];
       
       // NSLog(@"Is there a match  %@", match?@"YES":@"NO");
        
        if(match)
        {
           // NSLog(@" firstwordcaitalized == %@",itemCategoryTag);
            return true;
        }
    }

    return false;
}



@end
