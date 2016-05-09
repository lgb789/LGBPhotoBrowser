//
//  LGBPhotoBrowserCell.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/3.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPhotoBrowserCell.h"


@interface LGBPhotoBrowserCell ()

@end

@implementation LGBPhotoBrowserCell

#pragma mark - *********************** public methods ***********************

-(void)cleanZoom
{
    [self.imageView cleanZoom];
}

-(void)configCellWithData:(LGBPhotoModel *)model
{
//    [self.imageView.imageView yy_setImageWithURL:[NSURL URLWithString:model.bigImageURL] placeholder:model.smallImageView.image options:YYWebImageOptionProgressiveBlur completion:nil];
//    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
}

#pragma mark - *********************** overwrite methods ***********************

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setImageFrame];
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************
-(void)setImageFrame
{
    CGFloat width = 0;
    CGFloat height = 0;
    
    CGFloat selfWidth = MIN(CGRectGetWidth(self.bounds), [UIScreen mainScreen].bounds.size.width);
    CGFloat selfHeight = MIN(CGRectGetHeight(self.bounds), [UIScreen mainScreen].bounds.size.height);
    
    UIImage *img = self.imageView.imageView.image;
//    DLog(@"big image-->%f,%f", img.size.width, img.size.height);
    
    CGFloat widthRatio = selfWidth / img.size.width;
    CGFloat heightRatio = selfHeight / img.size.height;
    CGFloat scale = MIN(widthRatio, heightRatio);
    width = scale * img.size.width;
    height = scale * img.size.height;
    
//    DLog(@"width height:%f,%f", width, height);
    self.imageView.frame = CGRectMake(selfWidth / 2 - width / 2, selfHeight / 2 - height / 2, width, height);
    
}

#pragma mark - *********************** getters and setters ***********************
-(LGBPhotoImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [LGBPhotoImageView new];
    }
    return _imageView;
}

-(void)setSingleTap:(SingleTapHandler)singleTap
{
    if (_singleTap == singleTap) {
        return;
    }
    _singleTap = singleTap;
    self.imageView.singleTap = _singleTap;
}

@end
