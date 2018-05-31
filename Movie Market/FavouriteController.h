//
//  FavouriteController.h
//  Movie Market
//
//  Created by Admin on 5/16/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeDelegate.h"
#import "FavouriteViewModel.h"
#import "MovieDetailsController.h"

@interface FavouriteController : UICollectionViewController<HomeDelegate>{
    
@private
    NSMutableArray *moviesArray;
}


@property (strong, nonatomic) IBOutlet UICollectionView *favouriteCollection;

@end
