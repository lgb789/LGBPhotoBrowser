//
//  LGBPhotoModel.h
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/5.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGBPhotoModel : NSObject
@property (nonatomic, weak) UIImageView *smallImageView;
@property (nonatomic, copy) NSString *bigImageURL;
@end
