//
//  HomeViewModel.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHandler.h"
#import "HomeModelViewDelegate.h"
#import "Movie.h"
#import "HomeDelegate.h"
#import "DBManager.h"

@interface HomeViewModel : NSObject <HomeModelViewDelegate>{
    
    @private
    RequestHandler *myRequestHandler;
    NSMutableArray *myMoviesList;
    int pagesCount;
    DBManager *dbManager;
    
}

@property id<HomeDelegate> homeView;

-(void) requestApiResponse ;
-(void) cashMovie : (Movie *) movie;
-(void) getChashedMovies;
-(void) notifyHomeWithMovies : (NSArray *)movies;

@end
