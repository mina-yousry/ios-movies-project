//
//  HomeModelViewDelegate.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelViewDelegate <NSObject>

-(void) didFinishApiResponse : (NSArray *) moviesList;
-(void) notifyHomeWithMovies : (NSArray *)movies;

@end
