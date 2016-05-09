//
//  LGBPhotoView.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBPhotoCell.h"

@interface LGBPhotoView : UIScrollView

/**
 *  图片左右间距，默认5
 */
@property (nonatomic, assign) CGFloat itemSpace;

/**
 *  图片上下间距，默认5
 */
@property (nonatomic, assign) CGFloat lineSpace;

/**
 *  一行显示多少张图片，默认3
 */
@property (nonatomic, assign) NSUInteger rowItems;

@property (nonatomic, strong) NSArray *imageURL;

-(void)setPhotos:(NSArray *)photos;

@end
