//
//  LGBPhotoImageView.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/4.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPhotoImageView.h"

#define kMaxScale           3.0
#define kMinScale           1.0

@interface LGBPhotoImageView () <UIScrollViewDelegate>
@property (nonatomic, assign) BOOL isScale;
@property (nonatomic, assign) BOOL isDismiss;

@end

@implementation LGBPhotoImageView

#pragma mark - *********************** public methods ***********************

-(void)cleanZoom
{
//    DLog(@"clean zoom.....:%d", self.isScale);
    [self setZoomScale:kMinScale animated:NO];
    [self setContentOffset:CGPointZero animated:NO];
    self.isScale = NO;
}

#pragma mark - *********************** overwrite methods ***********************

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor blackColor];
        self.minimumZoomScale = kMinScale;
        self.maximumZoomScale = kMaxScale;
        self.delegate = self;
        [self addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.zoomScale == kMinScale && self.isDismiss == NO) {
        self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        self.imageView.frame = self.bounds;
    }
    
}

#pragma mark - *********************** delegate ***********************

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect frame = self.imageView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    if (CGRectGetWidth(frame) < CGRectGetWidth(self.bounds)) {
        frame.origin.x = floor((CGRectGetWidth(self.bounds) - CGRectGetWidth(frame)) / 2);
    }
    if (CGRectGetHeight(frame) < CGRectGetHeight(self.bounds)){
        frame.origin.y = floor((CGRectGetHeight(self.bounds) - CGRectGetHeight(frame)) / 2);
    }
    self.imageView.frame = frame;
//    DLog(@"image frame-->%@", NSStringFromCGRect(self.imageView.frame));
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.isScale = scale > kMinScale ? YES : NO;
}

#pragma mark - *********************** event response ***********************
-(void)tapHandler:(UITapGestureRecognizer *)recognizer
{

    self.isDismiss = YES;
    if (self.singleTap) {
        self.singleTap();
    }
    
}

-(void)doubleTapHandler:(UITapGestureRecognizer *)recognizer
{
    self.isScale = !self.isScale;
//    DLog(@"is scale:%d", self.isScale);
    if (self.isScale) {
        CGPoint point = [recognizer locationInView:self.imageView];
        point = CGPointMake(point.x * (kMaxScale - 1), point.y * (kMaxScale - 1));

        [UIView animateWithDuration:0.3 animations:^{
            [self setZoomScale:kMaxScale animated:NO];
            [self setContentOffset:point animated:NO];
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            [self setZoomScale:kMinScale animated:NO];
            [self setContentOffset:CGPointZero animated:NO];
        }];
        
    }
    
}

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        tap.numberOfTapsRequired = 1;
        [_imageView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapHandler:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
        
        [tap requireGestureRecognizerToFail:doubleTap];
        
    }
    return _imageView;
}

@end
