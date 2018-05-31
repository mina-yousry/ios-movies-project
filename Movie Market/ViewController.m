//
//  ViewController.m
//  Movie Market
//
//  Created by Mina on 5/7/18.
//  Copyright © 2018 Mina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewModel *homeModelView = [HomeViewModel new];
    [homeModelView requestApiResponse];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
