//
//  LGBMainViewController.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/9.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "LGBMainViewController.h"
#import "LGBViewController.h"

@interface LGBMainViewController ()

@end

@implementation LGBMainViewController

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleRightButton)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */

    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* add notificatioin */
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* remove notificatioin */
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************
-(void)handleRightButton
{
    [self.navigationController pushViewController:[LGBViewController new] animated:YES];
}

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    
}

#pragma mark - *********************** getters and setters ***********************

@end
