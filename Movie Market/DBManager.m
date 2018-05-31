//
//  DBManager.m
//  FriendsProject
//
//  Created by Mina on 4/30/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

- (instancetype)init {
    return [DBManager sharedInctance];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
    }
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"friends.db"]];
    
    
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt =
        "CREATE TABLE IF NOT EXISTS MOVIES (MOVIE_ID TEXT PRIMARY KEY , TITLE TEXT, POSTER_PATH TEXT, RATE TEXT, OVER_VIEW TEXT, YEAR TEXT, FAVOURITE INTEGER)";
        
        if (sqlite3_exec(_moviesDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create table");
        }
        sqlite3_close(_moviesDB);
        NSLog(@"movies table created");
    } else {
        NSLog(@"Failed to open/create database");
    }
    
    return self;
}




+(DBManager *)sharedInctance{
    
    static DBManager *sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate , ^{
        sharedInstance = [[DBManager alloc]initPrivate];
    });

    return sharedInstance;
}



//-(instancetype)init{
//    
//    NSString *docsDir;
//    NSArray *dirPaths;
//    
//    // Get the documents directory
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    docsDir = dirPaths[0];
//    
//    // Build the path to the database file
//    _databasePath = [[NSString alloc]
//                     initWithString: [docsDir stringByAppendingPathComponent:
//                                      @"friends.db"]];
//    
//    
//    const char *dbpath = [_databasePath UTF8String];
//    
//    if (sqlite3_open(dbpath, &_friendsDB) == SQLITE_OK)
//    {
//        char *errMsg;
//        const char *sql_stmt =
//        "CREATE TABLE IF NOT EXISTS FRIENDS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER, PHONE TEXT, IMAGE_NAME TEXT, GENDER TEXT)";
//        
//        if (sqlite3_exec(_friendsDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
//        {
//            NSLog(@"Failed to create table");
//        }
//        sqlite3_close(_friendsDB);
//    } else {
//        NSLog(@"Failed to open/create database");
//    }
//    
//    return self;
//}

- (void) addMovie :(Movie *)addedMovie{
    
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO movies (movie_id, title, poster_path, rate, over_view, year, favourite) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\")",
                               addedMovie.moviewId, addedMovie.moviTitle, addedMovie.moviewPosterPath, addedMovie.movieRate, addedMovie.movieOverview, addedMovie.movieYear, addedMovie.favourite];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_moviesDB, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"movie added sucessfully");
        } else {
            NSLog(@"failed to add movie");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_moviesDB);
    }

}

//- (void) removeFriend :(FriendModel *)removedFriend{
//
//    sqlite3_stmt    *statement;
//    const char *dbpath = [_databasePath UTF8String];
//
//    printf("removed friend id : %d \n",removedFriend.friendId);
//
//    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
//    {
//
//        NSString *deleteSQL = [NSString stringWithFormat:
//                               @"DELETE FROM friends WHERE id=\"%d\"",removedFriend.friendId];
//
//        const char *delete_stmt = [deleteSQL UTF8String];
//        sqlite3_prepare_v2(_friendsDB, delete_stmt,-1, &statement, NULL);
//
//        if (sqlite3_step(statement) == SQLITE_DONE)
//        {
//            NSLog(@"friend removed sucessfully");
//        } else {
//            NSLog(@"failed to remove friend");
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(_moviesDB);
//    }
//}

- (void) getCahsedMovies{
    
    NSMutableArray *movies = [NSMutableArray new];
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM movies"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_moviesDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *movieId = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 0)];
                
                NSString *movieTitle = [[NSString alloc]
                                          initWithUTF8String:(const char *)
                                          sqlite3_column_text(statement, 1)];

                NSString *posterPath = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 2)];
                
                NSString *rate = [[NSString alloc]
                                       initWithUTF8String:(const char *)
                                       sqlite3_column_text(statement, 3)];
                
                NSString *overView = [[NSString alloc]
                                       initWithUTF8String:(const char *)
                                       sqlite3_column_text(statement, 4)];
                
                NSString *year = [[NSString alloc]
                                             initWithUTF8String:(const char *)
                                             sqlite3_column_text(statement, 5)];
                
                int favourite = [[[NSString alloc]
                                initWithUTF8String:(const char *)
                                sqlite3_column_text(statement, 6)] intValue];
                
                Movie *currentMovie = [[Movie new]initWithId:movieId
                                                    AndTitle:movieTitle
                                                   AndPoster:posterPath
                                                     AndRate:rate
                                                 AndOverView:overView
                                                     AndYear:year
                                                AndFavourite:favourite];
                [movies addObject:currentMovie];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_moviesDB);
    }
    
    [_homeController notifyHomeWithMovies:movies];
}

- (void) getFavouriteMovies{
    NSMutableArray *movies = [NSMutableArray new];
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM movies WHERE favourite = '1'"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_moviesDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *movieId = [[NSString alloc]
                                     initWithUTF8String:(const char *)
                                     sqlite3_column_text(statement, 0)];
                
                NSString *movieTitle = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                
                NSString *posterPath = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 2)];
                
                NSString *rate = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 3)];
                
                NSString *overView = [[NSString alloc]
                                      initWithUTF8String:(const char *)
                                      sqlite3_column_text(statement, 4)];
                
                NSString *year = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 5)];
                
                int favourite = [[[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 6)] intValue];
                
                Movie *currentMovie = [[Movie new]initWithId:movieId
                                                    AndTitle:movieTitle
                                                   AndPoster:posterPath
                                                     AndRate:rate
                                                 AndOverView:overView
                                                     AndYear:year
                                                AndFavourite:favourite];
                [movies addObject:currentMovie];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_moviesDB);
    }
    
    [_favouriteController showFavouriteMovies:movies];
}

- (Movie *) getMovieWithId : (NSString *)Id{
    
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    Movie *currentMovie = nil;
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM movies WHERE movie_id = \"%@\"",Id];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_moviesDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *movieId = [[NSString alloc]
                                     initWithUTF8String:(const char *)
                                     sqlite3_column_text(statement, 0)];
                
                NSString *movieTitle = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                
                NSString *posterPath = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 2)];
                
                NSString *rate = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 3)];
                
                NSString *overView = [[NSString alloc]
                                      initWithUTF8String:(const char *)
                                      sqlite3_column_text(statement, 4)];
                
                NSString *year = [[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 5)];
                
                int favourite = [[[NSString alloc]
                                  initWithUTF8String:(const char *)
                                  sqlite3_column_text(statement, 6)] intValue];
                
                currentMovie = [[Movie new]initWithId:movieId
                                             AndTitle:movieTitle
                                            AndPoster:posterPath
                                              AndRate:rate
                                          AndOverView:overView
                                              AndYear:year
                                         AndFavourite:favourite];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_moviesDB);
    }
    
    return currentMovie;
}

- (Boolean) updateMovieWithId : (Movie *)updatedMovie{
    Boolean success = NO;
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_moviesDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE movies SET title=\"%@\", poster_path=\"%@\", rate=\"%@\", over_view=\"%@\", year=\"%@\", favourite = \"%d\" where movie_id=\"%@\"",updatedMovie.moviTitle, updatedMovie.moviewPosterPath, updatedMovie.movieRate, updatedMovie.movieOverview, updatedMovie.movieYear, updatedMovie.favourite,updatedMovie.moviewId];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_moviesDB, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
            
        } else {
            NSLog(@"failed to add movie");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_moviesDB);
    }
    return success;
}

@end
