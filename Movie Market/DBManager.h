//
//  DBManager.h
//  FriendsProject
//
//  Created by Mina on 4/30/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Movie.h"
#import "FavouriteVMProtocol.h"
#import "HomeModelViewDelegate.h"

@interface DBManager : NSObject

@property (strong , nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *moviesDB;
@property id<FavouriteVMProtocol> favouriteController;
@property id<HomeModelViewDelegate> homeController;


- (void) addMovie :(Movie *)addedMovie;
//- (void) removeMovie :(Movie *)removedMovie; 
- (void) getCahsedMovies;
- (void) getFavouriteMovies;
- (Movie *) getMovieWithId : (NSString *)Id;
- (Boolean) updateMovieWithId : (Movie *)updatedMovie;
- (instancetype)initPrivate;
+(DBManager *)sharedInctance;

@end
