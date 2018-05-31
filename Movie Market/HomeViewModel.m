//
//  HomeViewModel.m
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel


-(instancetype)init{
    
    
    pagesCount = 0;
    
    return self;
}

-(void) requestApiResponse{
    
    pagesCount ++;
    
    myRequestHandler = [RequestHandler new];
    myRequestHandler.homeModelViewDelegate = self;
    [myRequestHandler apiResponce : pagesCount];
    
}

-(void) didFinishApiResponse : (NSArray *) moviesList{
    
    myMoviesList = [NSMutableArray new];

    for (int i=0; i< moviesList.count ; i++) {
        Movie *movie = [Movie new];
        
        movie.moviewId = [NSString stringWithFormat:@"%@",moviesList[i][@"id"]];
        movie.moviTitle = moviesList[i][@"title"];
        movie.moviewPosterPath = [movie makePosterFullUrl:moviesList[i][@"poster_path"]];
        movie.movieRate = [NSString stringWithFormat:@"%@",moviesList[i][@"vote_average"]];
        //NSLog(@"%@",movie.movieRate);
        movie.movieYear = [movie extractYear: moviesList[i][@"release_date"]];
        movie.movieOverview = moviesList[i][@"overview"];
        //NSLog(@"%@",movie.moviewPosterPath);
        [myMoviesList addObject:movie];
    }
    
    [_homeView showMovies:myMoviesList];
    
}

-(void) getChashedMovies{
    dbManager = [DBManager sharedInctance];
    dbManager.homeController = self;
    [dbManager getCahsedMovies];
}
-(void) notifyHomeWithMovies : (NSArray *)movies{
    [_homeView showMovies:movies];
}

-(void) cashMovie : (Movie *) movie{
    dbManager = [DBManager sharedInctance];
    [dbManager addMovie:movie];
}
@end
