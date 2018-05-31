//
//  HomeDelegate.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeDelegate <NSObject>

-(void) showMovies : (NSArray *) movies;

@end
