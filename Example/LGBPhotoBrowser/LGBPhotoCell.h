//
//  LGBPhotoCell.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBPhotoCell : UICollectionViewCell 

@property (nonatomic, strong) UIImageView *imageView;

-(void)photoCellConfigWithData:(id)data;

@end
