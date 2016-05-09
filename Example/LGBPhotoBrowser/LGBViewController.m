//
//  LGBViewController.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 05/09/2016.
//  Copyright (c) 2016 lgb789. All rights reserved.
//

#import "LGBViewController.h"
#import "LGBPhotoView.h"

@interface LGBViewController ()
@property (nonatomic, strong) LGBPhotoView *photoView;
@end

@implementation LGBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"http://7xjtvh.com1.z0.glb.clouddn.com/browse01_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08_s.jpg",
                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09_s.jpg"];
    
    NSArray *bigUrlArray = @[@"http://7xjtvh.com1.z0.glb.clouddn.com/browse01.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08.jpg",
                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09.jpg"];
    
    [self.view addSubview:self.photoView];
    
    self.photoView.frame = CGRectMake(0, 0, 250, 0);
    self.photoView.rowItems = 3;
    [self.photoView setPhotos:array];
    self.photoView.imageURL = bigUrlArray;
    
    self.photoView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LGBPhotoView *)photoView
{
    if (_photoView == nil) {
        _photoView = [LGBPhotoView new];
        _photoView.backgroundColor = [UIColor grayColor];
    }
    return _photoView;
}

@end
