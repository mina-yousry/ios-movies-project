//
//  YoutubeRedirector.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface YoutubeRedirector : NSObject


-(void) redirectToMovieTrailerWithId :(NSString *) movieId;

@end
