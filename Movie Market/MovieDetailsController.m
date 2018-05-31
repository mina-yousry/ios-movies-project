//
//  MovieDetailsController.m
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "MovieDetailsController.h"

@interface MovieDetailsController (){
    
    MovieDetailsViewModel *myModelView;
}

@end

@implementation MovieDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myModelView = [MovieDetailsViewModel new];
    
    self.title = @"Movie Details";
    
    if (_selectedMovie != nil) {
        _movieTitleLabel.text = _selectedMovie.moviTitle;
        _movieYealLabel.text = _selectedMovie.movieYear;
        _movieRateLable.text = _selectedMovie.movieRate;
        _movieOverViewTextView.text = _selectedMovie.movieOverview;
        
        
        [_moviePosterImageView sd_setImageWithURL:[NSURL URLWithString: _selectedMovie.moviewPosterPath]
                         placeholderImage:[UIImage imageNamed:@"Loading_icon.gif"]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    if(_selectedMovie.favourite == 1){
        [_makeFavBtn setTitle:@"Unfavourite" forState:UIControlStateNormal];
    }else{
        [_makeFavBtn setTitle:@"Make favourite" forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playYoutubeTrailer:(id)sender {
    [myModelView playMovieTrailer:_selectedMovie.moviewId];
}

- (IBAction)makeMovieFavourite:(id)sender {
    
    FavouriteViewModel *myFavModel = [[FavouriteViewModel alloc]init];
    if(_selectedMovie.favourite == 1){
        _selectedMovie.favourite = 0;
    }else{
        _selectedMovie.favourite = 1;
    }
    [myFavModel makeFavourite:_selectedMovie];
}


@end
