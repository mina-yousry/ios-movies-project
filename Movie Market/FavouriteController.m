//
//  FavouriteController.m
//  Movie Market
//
//  Created by Admin on 5/16/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "FavouriteController.h"

@interface FavouriteController (){
    FavouriteViewModel *favViewModel;
}

@end

@implementation FavouriteController

static NSString * const reuseIdentifier = @"CellFavourite";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    
    moviesArray = [NSMutableArray new];
    favViewModel = [[FavouriteViewModel alloc]init];
    favViewModel.favouriteView = self;
    [favViewModel getFavouriteMovies];
    NSLog(@"get favourite movies called");
    self.title = @"Favourites";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear");
    [super viewWillAppear:YES];
    [favViewModel getFavouriteMovies];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:3];
    
    Movie *cellMovie = [Movie new];
    cellMovie = moviesArray[indexPath.item];
    [cellImageView sd_setImageWithURL:[NSURL URLWithString: cellMovie.moviewPosterPath]
                     placeholderImage:[UIImage imageNamed:@"Loading_icon.gif"]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailsController *movieDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"movieDetails"];
    movieDetails.selectedMovie = moviesArray[indexPath.item];
    [self.navigationController pushViewController:movieDetails animated:YES];
    
}

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

-(void) showMovies : (NSArray *) movies{
    
    NSLog(@"show movies called");
    [moviesArray removeAllObjects];
    for (int i=0; i<movies.count; i++) {
        [moviesArray addObject:movies[i]];
    }
    [_favouriteCollection reloadData];
}
@end
