//
//  HomeCollectionViewController.h
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeDelegate.h"
#import "HomeViewModel.h"
#import "MovieDetailsController.h"
#import "Reachability.h"

@interface HomeCollectionViewController : UICollectionViewController <HomeDelegate>{
    
@private
    NSMutableArray *moviesArray;
}

@property (strong, nonatomic) IBOutlet UICollectionView *homeCollectionView;


@end
