//
//  HomeCollectionViewController.m
//  Movie Market
//
//  Created by Mina on 5/8/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "HomeCollectionViewController.h"

@interface HomeCollectionViewController (){
    HomeViewModel *homeViewModel;
}

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    moviesArray = [NSMutableArray new];
    homeViewModel = [HomeViewModel new];
    homeViewModel.homeView = self;
    
    self.title = @"Home";
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [homeViewModel getChashedMovies];
    }
    else
    {
        [homeViewModel requestApiResponse];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:2];
    
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate == NO) {
        [homeViewModel requestApiResponse];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSArray *visibleRows = [_homeCollectionView visibleCells];
    UICollectionViewCell *lastVisibleCell = [visibleRows lastObject];
    NSIndexPath *path = [_homeCollectionView indexPathForCell:lastVisibleCell];
    if(path.row == moviesArray.count)
    {
        [homeViewModel requestApiResponse];
    }
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
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        for (int i=0; i<movies.count; i++) {
            [moviesArray addObject:movies[i]];
        }
    }
    else
    {
        for (int i=0; i<movies.count; i++) {
            [moviesArray addObject:movies[i]];
            if(i<=10){
                [homeViewModel cashMovie:movies[i]];
            }
        }
    }


    [_homeCollectionView reloadData];
}

@end
