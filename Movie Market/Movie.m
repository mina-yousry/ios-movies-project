//
//  Movie.m
//  Movie Market
//
//  Created by Mina on 5/7/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithId : (NSString *) movieId
                 AndTitle : (NSString *) title
                AndPoster : (NSString *) poster
                  AndRate : (NSString *) rate
              AndOverView : (NSString *) overView
                  AndYear : (NSString *) year
             AndFavourite : (int) favourite{
    self.moviewId = movieId;
    self.moviTitle = title;
    self.moviewPosterPath = poster;
    self.movieRate = rate;
    self.movieOverview = overView;
    self.movieYear = year;
    self.favourite = favourite;
    
    return self;
}

-(NSString *) makePosterFullUrl : (NSString *) relativeUrl{
    
    NSString *fullPosterUrl = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w185/%@",relativeUrl];
    return fullPosterUrl;
}

-(NSString *) extractYear : (NSString *) date{
    
    NSArray *dateParts = [date componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    //NSLog(@"%@",dateParts[0]);
    return dateParts[0];
}
@end
