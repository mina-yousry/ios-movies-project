//
//  FavouriteViewModel.m
//  Movie Market
//
//  Created by Admin on 5/16/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "FavouriteViewModel.h"

@implementation FavouriteViewModel


- (instancetype)init
{
    dbManager = [DBManager sharedInctance];
    dbManager.favouriteController = self;
    return self;
}
- (void) getFavouriteMovies{
    NSLog(@"get favourite movies");
    [dbManager getFavouriteMovies];
}

- (void) updateFavouriteMovie : (Movie *) movie{
    [dbManager updateMovieWithId:movie];
}

- (void) makeFavourite : (Movie *) favMovie{
    Movie *tempMovie = [dbManager getMovieWithId:favMovie.moviewId];
    if(tempMovie == nil){
        [dbManager addMovie:favMovie];
    }else{
        [dbManager updateMovieWithId:favMovie];
    }
    
}

-(void) showFavouriteMovies : (NSMutableArray *) movies{
    NSLog(@"showFavouriteMovies called from favourite view model");
    Movie *tempMovie = [movies lastObject];
    NSLog(@"%@",tempMovie.moviTitle);
    [_favouriteView showMovies:movies];
}

@end
