//
//  YoutubeRedirector.m
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "YoutubeRedirector.h"

@implementation YoutubeRedirector

-(void) redirectToMovieTrailerWithId :(NSString *)movieId{
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.themoviedb.org/3/movie/%@/videos?api_key=3767afed20bb97bf23a1b95512fa717e",movieId];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    
    
    [manager    GET:URL.absoluteString
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                NSDictionary *fullResponse = (NSDictionary *)responseObject;
                NSArray *trailersList = fullResponse[@"results"];
                NSString *key = trailersList[0][@"key"];
                NSString *youtubeLink = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",key];
                //NSLog(@"%@",youtubeLink);
                NSURL *youtubeUrl = [NSURL URLWithString:youtubeLink];
                if ([[UIApplication sharedApplication] canOpenURL:youtubeUrl]) {
                    [[UIApplication sharedApplication] openURL:youtubeUrl];
                }
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"%@",error);
            }
     ];

}

@end
