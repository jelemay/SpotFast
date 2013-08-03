//
//  SpotSecondViewController.m
//  Spot
//
//  Created by John Lemay on 7/17/13.
//  Copyright (c) 2013 John Lemay. All rights reserved.
//

#import "SpotRecentViewController.h"
#import "FlickrFetcher.h"

@interface SpotRecentViewController ()

@end

@implementation SpotRecentViewController

// sets the Model
// reloads the UITableView (since Model is changing)

- (void)setPhotos:(NSArray *)photos
{
   
    _photos=photos;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
   // NSLog(@"starting prepare for segue");
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
       // NSLog(@"sender is kind of UITableviewCell");
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
           // NSLog(@"found an index path");
          
            if ([segue.identifier isEqualToString:@"Show Image"]) {
               //   NSLog(@"found a seque identifier");
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)])
                {
               //      NSLog(@"found selector");
                    NSURL *url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
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
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}


@end
