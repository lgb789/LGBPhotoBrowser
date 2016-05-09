//
//  LGBPhotoBrowser.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/3.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGBPhotoBrowserCell.h"
#import "LGBPhotoModel.h"

@interface LGBPhotoBrowser : UIView

/**
 *  图片间距，默认50
 */
@property (nonatomic, assign) CGFloat itemSpace;

-(void)setData:(NSArray *)data;

-(void)showItem:(NSUInteger)item;

-(void)registerCellClass:(Class)cellClass;

@end
