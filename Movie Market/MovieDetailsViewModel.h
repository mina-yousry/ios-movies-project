//
//  MovieDetailsViewModel.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeRedirector.h"

@interface MovieDetailsViewModel : NSObject

-(void) playMovieTrailer:(NSString *)movieId;

@end
