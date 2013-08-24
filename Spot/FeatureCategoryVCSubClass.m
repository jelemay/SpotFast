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
  
    [self.refreshControl addTarget: self action:@selector(loadLatestPhotos) forControlEvents: UIControlEventValueChanged];
    [self loadLatestPhotos];
    
 //  [self createPhotoCategories];
    }



-(void) loadLatestPhotos
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t loaderQ = dispatch_queue_create("flickrLatestLoader",NULL);
      [UIApplication sharedApplication].networkActivityIndicatorVisible=YES; 
    
    dispatch_async(loaderQ,^{
    
    // self.photos = [FlickrFetcher stanfordPhotos];
       
    NSArray * latestPhotos = [FlickrFetcher stanfordPhotos];
        
    // backto UI thread
        dispatch_async(dispatch_get_main_queue(),^{
              [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            self.photos= latestPhotos;         
            [self createPhotoCategories];
            [self createSortedPhotoCategories];
             [self.tableView reloadData];
            
            
         NSLog(@" photos array count %d", self.photos.count);
               NSLog(@" photoCategories array %@", self.photoCategories);
    

            
            [self.refreshControl endRefreshing];
        });
        
    });
}

-(void) createSortedPhotoCategories
{
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"categoryTag"
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [self.photoCategories sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *mutableSortedArray =[NSMutableArray arrayWithCapacity:100] ;
    [mutableSortedArray addObjectsFromArray:sortedArray];
    self.photoCategories = mutableSortedArray;
    
}
                   
- (void) createPhotoCategories
{
    NSMutableArray * myArrayPhotos=[[NSMutableArray alloc]init];
    NSDictionary * item;
    [self.photoCategories removeAllObjects];
    
    for ( item in self.photos)
    {
       
        [myArrayPhotos addObject:(NSDictionary *)item ];
        NSString * firstWord= [[item objectForKey:@"tags"] componentsSeparatedByString:@" "] [0];
        NSString * firstWordCapitalized= [firstWord capitalizedString];
        [self addToCategories:firstWordCapitalized itemDictionary:item];
               
    }

   // NSLog(@"  photoCategories count %d", self.photoCategories.count);
  //  NSLog(@" photoCategories array %@", self.photoCategories);
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
