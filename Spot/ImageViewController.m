//
//  ImageViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

// resets the image whenever the URL changes

- (void)setImageURL:(NSURL *)imageURL
{ //NSLog(@" entered from segue");
    _imageURL = imageURL;
    [self resetImage];
}

// fetches the data from the URL
// turns it into an image
// adjusts the scroll view's content size to fit the image
// sets the image as the image view's image

- (void)resetImage
{
    NSURL * imageURL=self.imageURL;
    [ self.spinner startAnimating];
    dispatch_queue_t downloadQueue =dispatch_queue_create("imagedownloader", NULL);
    dispatch_async(downloadQueue,^{
              [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        
             NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
           [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
            UIImage *image = [[UIImage alloc] initWithData:imageData];
  
        if(imageURL ==self.imageURL)
        {
    dispatch_async(dispatch_get_main_queue(),^{
    
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
 
        if (image) {
            self.scrollView.zoomScale = 1.0;
            self.scrollView.contentSize = image.size;
            self.imageView.image = image;
         
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
             self.scrollView.zoomScale=self.scrollView.frame.size.width/self.imageView.frame.size.width;
            
        }
    }
          [ self.spinner stopAnimating];
        });
        }
    
   });
}

// lazy instantiation

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

// returns the view which will be zoomed when the user pinches
// in this case, it is the image view, obviously
// (there are no other subviews of the scroll view in its content area)

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

// add the image view to the scroll view's content area
// setup zooming by setting min and max zoom scale
//   and setting self to be the scroll view's delegate
// resets the image in case URL was set before outlets (e.g. scroll view) were set

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
}
-(void) viewDidLayoutSubviews
{
    self.scrollView.zoomScale=self.scrollView.frame.size.width/self.imageView.frame.size.width;
   
}
@end
