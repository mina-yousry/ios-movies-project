//
//  RequestHandler.h
//  Movie Market
//
//  Created by Mina on 5/7/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "HomeModelViewDelegate.h"

@interface RequestHandler : NSObject

@property id<HomeModelViewDelegate> homeModelViewDelegate;

-(void) apiResponce : (int) pageCount;
@end
