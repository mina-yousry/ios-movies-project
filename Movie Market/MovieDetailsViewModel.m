//
//  MovieDetailsViewModel.m
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "MovieDetailsViewModel.h"

@implementation MovieDetailsViewModel

-(void) playMovieTrailer:(NSString *)movieId{
    
    YoutubeRedirector *director = [YoutubeRedirector new];
    [director redirectToMovieTrailerWithId:movieId];
}

@end

