//
//  RequestHandler.m
//  Movie Market
//
//  Created by Mina on 5/7/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "RequestHandler.h"

@implementation RequestHandler

-(void) apiResponce : (int) pageCount{
    
    __block NSString *response;
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=3767afed20bb97bf23a1b95512fa717e&page=%d",pageCount];
    NSURL *URL = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    [manager    GET:URL.absoluteString
         parameters:nil
           progress:nil
            success:^(NSURLSessionTask *task, id responseObject) {
                //NSLog(@"JSON: %@", responseObject);
                response = responseObject;
                //NSLog(@"JSON: %@", response);
                NSDictionary *fullResponse = (NSDictionary *)responseObject;
                NSArray *moviesList = fullResponse[@"results"];
                [_homeModelViewDelegate didFinishApiResponse:moviesList];   
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                response = nil;
            }
     ];
}

@end
