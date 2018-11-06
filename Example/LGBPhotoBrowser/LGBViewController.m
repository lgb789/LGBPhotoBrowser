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
    
    NSArray *array = @[
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541504893583&di=e044ad4659c49a40e00f9ff789ec5077&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F23%2F09%2F74T58PICZjg_1024.jpg",
                       @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=651563529,3849161361&fm=26&gp=0.jpg",
                       @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2109332669,47160988&fm=26&gp=0.jpg",
                       @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1209999726,4159293143&fm=27&gp=0.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1541495952&di=95afb9c45682d55db13d16d69243a5d5&src=http://pic.58pic.com/58pic/13/04/43/55e58PICY6N_1024.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse01_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08_s.jpg",
//                       @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09_s.jpg"
                       ];
    
    NSArray *bigUrlArray = @[
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541504893583&di=e044ad4659c49a40e00f9ff789ec5077&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F23%2F09%2F74T58PICZjg_1024.jpg",
                             @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=651563529,3849161361&fm=26&gp=0.jpg",
                             @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2109332669,47160988&fm=26&gp=0.jpg",
                             @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1209999726,4159293143&fm=27&gp=0.jpg",
                             @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1541495952&di=95afb9c45682d55db13d16d69243a5d5&src=http://pic.58pic.com/58pic/13/04/43/55e58PICY6N_1024.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse01.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse02.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse03.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse04.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse05.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse06.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse07.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse08.jpg",
//                             @"http://7xjtvh.com1.z0.glb.clouddn.com/browse09.jpg"
                             ];
    
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
