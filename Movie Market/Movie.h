//
//  Movie.h
//  Movie Market
//
//  Created by Mina on 5/7/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *moviewId;
@property NSString *moviTitle;
@property NSString *moviewPosterPath;
@property NSString *movieRate;
@property NSString *movieOverview;
@property NSString *movieYear;
@property int favourite;

-(NSString *) makePosterFullUrl : (NSString *) relativeUrl;
-(NSString *) extractYear : (NSString *) date;
- (instancetype)initWithId : (NSString *) movieId
                  AndTitle : (NSString *) title
                 AndPoster : (NSString *) poster
                   AndRate : (NSString *) rate
               AndOverView : (NSString *) overView
                   AndYear : (NSString *) year
              AndFavourite : (int) favourite;


@end
