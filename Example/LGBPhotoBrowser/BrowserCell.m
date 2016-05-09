//
//  BrowserCell.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/9.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "BrowserCell.h"
#import "YYWebImage.h"

@implementation BrowserCell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
-(void)configCellWithData:(LGBPhotoModel *)model
{
//    DLog(@"config cell");
    [self.imageView.imageView yy_setImageWithURL:[NSURL URLWithString:model.bigImageURL] placeholder:model.smallImageView.image options:YYWebImageOptionProgressiveBlur completion:nil];
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************


@end
