//
//  LGBPhotoBrowserCell.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/3.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBPhotoImageView.h"
#import "LGBPhotoModel.h"

@interface LGBPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, copy) SingleTapHandler singleTap;

@property (nonatomic, strong) LGBPhotoImageView *imageView;

-(void)cleanZoom;

//子类重写此方法
-(void)configCellWithData:(LGBPhotoModel *)model;

@end
