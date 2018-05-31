//
//  MovieDetailsController.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie.h"
#import "MovieDetailsViewModel.h"
#import "FavouriteViewModel.h"

@interface MovieDetailsController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *makeFavBtn;
@property (strong, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieYealLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieRateLable;
@property (strong, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (strong, nonatomic) IBOutlet UITextView *movieOverViewTextView;

@property Movie *selectedMovie;


- (IBAction)playYoutubeTrailer:(id)sender;
- (IBAction)makeMovieFavourite:(id)sender;


@end
