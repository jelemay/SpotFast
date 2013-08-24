//
//  FeatureCategoryPhotosVC.m
//  Spot
//
//  Created by John Lemay on 7/24/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "FeatureCategoryPhotosVC.h"
#import "FlickrFetcher.h"
#import "PhotoCache.h"

@interface FeatureCategoryPhotosVC ()

@end

@implementation FeatureCategoryPhotosVC


// sets the Model
// reloads the UITableView (since Model is changing)

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // [self.tableView reloadData];
  //  NSLog(@"view was loaded");
}
-(void) resetPhotos: (NSArray *) inPhotos
{
    self.photos=inPhotos;
     [self.tableView reloadData];
   //     NSLog(@"received seque request");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// prepares for the "Show Image" segue by seeing if the destination view controller of the segue
//  understands the method "setImageURL:"
// if it does, it sends setImageURL: to the destination view controller with
//  the URL of the photo that was selected in the UITableView as the argument
// also sets the title of the destination view controller to the photo's title

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
          
            if ([segue.identifier isEqualToString:@"Show Image"]) {
               //   NSLog(@"found a seque identifier");
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)])
                {
                    //   NSLog(@"found selector");
                    NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
                    
                    
                    PhotoCache *cache  = [[PhotoCache alloc] init];
                    [cache createFilesystem];
                
               //     NSLog(@"string for URL   %@",[url absoluteString]);
               //     NSArray * stringItems= [[url absoluteString] componentsSeparatedByString:@"/"];
                    
                //    NSLog(@"string for URL segmented   %@",stringItems);
                //    NSLog(@"string for URL segmented   %@",[stringItems lastObject]);
                    
                    
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                    
                    [self pushToRecentPhotoSet:self.photos[indexPath.row]];
                }
            }
        }
    }
}

-(void) pushToRecentPhotoSet:(NSDictionary *) currentPhoto{
    NSMutableArray * recentPhotoArray= [[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // if the recentPhotoArray doesn't exist add the dictionary for the current photo
    
    if( ![defaults arrayForKey:@"recentPhotoArray" ])
    {
       // [recentPhotoArray addObjectsFromArray:[defaults arrayForKey:@"recentPhotoArray" ]];
        [recentPhotoArray addObject:currentPhoto];
        [defaults setObject:recentPhotoArray forKey:@"recentPhotoArray"];
        [defaults synchronize];
        NSLog(@" added first dictionary to NSUserDefaults %@",[defaults arrayForKey:@"recentPhotoArray"]);
        
    }
    else
    {
        // remove duplicates
        //  add this object to the front
        //remove the last object if there are more than 6 stored
        
        
        [recentPhotoArray addObjectsFromArray:[defaults arrayForKey:@"recentPhotoArray"]];
        NSDictionary * item;
        NSInteger itemIndex =-1;
        NSInteger itemFound =-1;
        for(item in recentPhotoArray)
        {
            itemIndex++;
           //  NSLog(@"testing for  match");
            if([item isEqualToDictionary:currentPhoto])
            {
                itemFound=itemIndex;
            //    NSLog(@"found match , index is %d",itemFound);
              
            }
  
        }
      
        if(itemFound > -1)
        {
          //  NSLog(@"removing object");
            [recentPhotoArray removeObjectAtIndex:itemFound ];
        }
      
        [recentPhotoArray insertObject:currentPhoto atIndex:0];
        if(recentPhotoArray.count > 5) [recentPhotoArray removeLastObject];
       
        [defaults setObject:recentPhotoArray forKey:@"recentPhotoArray"];
        [defaults synchronize];
       // NSLog(@" the array in NSUserDefaults %@",[defaults arrayForKey:@"recentPhotoArray"]);
     
        
    }
    
    
    
    
}

// lets the UITableView know how many rows it should display
// in this case, just the count of dictionaries in the Model's array

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the title out of it

- (NSString *)titleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description]; // description because could be NSNull
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the owner of the photo out of it

- (NSString *)subtitleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_OWNER] description]; // description because could be NSNull
}

// loads up a table view cell with the title and owner of the photo at the given row in the Model

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
   // cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}


@end



