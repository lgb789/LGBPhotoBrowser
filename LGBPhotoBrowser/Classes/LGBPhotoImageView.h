//
//  LGBPhotoImageView.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/4.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SingleTapHandler)(void);

@interface LGBPhotoImageView : UIScrollView

@property (nonatomic, copy) SingleTapHandler singleTap;

@property (nonatomic, strong) UIImageView *imageView;

-(void)cleanZoom;

@end
