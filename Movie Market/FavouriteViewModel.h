//
//  FavouriteViewModel.h
//  Movie Market
//
//  Created by Admin on 5/16/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "HomeDelegate.h"
#import "DBManager.h"
#import "FavouriteVMProtocol.h"

@interface FavouriteViewModel : NSObject<FavouriteVMProtocol>{
    
@private
    NSMutableArray *myMoviesList;
    DBManager *dbManager;
}

@property id<HomeDelegate> favouriteView;

- (void) getFavouriteMovies;
- (void) updateFavouriteMovie : (Movie *) movie;
- (void) makeFavourite : (Movie *) favMovie;

@end
