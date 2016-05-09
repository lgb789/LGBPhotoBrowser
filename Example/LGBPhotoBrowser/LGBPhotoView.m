//
//  LGBPhotoView.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPhotoView.h"
#import "LGBPhotoBrowser.h"
#import "LGBPhotoModel.h"
#import "BrowserCell.h"

#define Identifier      @"Identifier"

@interface LGBPhotoView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) CGSize itemSize;
@end

@implementation LGBPhotoView

#pragma mark - *********************** public methods ***********************
-(void)setPhotos:(NSArray *)photos
{
    if (photos == nil) {
        return;
    }
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:photos];
    
    if (self.items.count < self.rowItems) {
        self.rowItems = self.items.count;
    }
    
    CGFloat itemWidth = (CGRectGetWidth(self.bounds) - (self.rowItems - 1) * self.itemSpace) / self.rowItems;
    NSUInteger rows = ceilf(self.items.count / (CGFloat)self.rowItems);
    
    CGFloat itemHeight = itemWidth;
    
    CGFloat selfHeight = itemHeight * rows + (rows - 1) * self.lineSpace;
    
    CGRect frame = self.frame;
    frame.size.height = selfHeight;
    self.frame = frame;
    
    self.itemSize = CGSizeMake(itemWidth, itemHeight);

}

#pragma mark - *********************** overwrite methods ***********************

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        self.itemSpace = 5;
        self.rowItems = 3;
        self.lineSpace = 5;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.itemSize;
    
    self.collectionView.frame = self.bounds;

}

#pragma mark - *********************** delegate ***********************

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBPhotoCell *c = (LGBPhotoCell *)cell;
    [c photoCellConfigWithData:self.items[indexPath.row]];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < self.items.count; i++) {
        LGBPhotoModel *model = [LGBPhotoModel new];
        LGBPhotoCell *c = (LGBPhotoCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        model.smallImageView = c.imageView;
        model.bigImageURL = self.imageURL[i];

        [models addObject:model];
    }
    
    LGBPhotoBrowser *browser = [LGBPhotoBrowser new];
    [browser registerCellClass:[BrowserCell class]];
    [browser setData:models];
    [browser showItem:indexPath.item];
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LGBPhotoCell class] forCellWithReuseIdentifier:Identifier];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

-(NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)setItemSpace:(CGFloat)itemSpace
{
    if (_itemSpace == itemSpace) {
        return;
    }
    _itemSpace = itemSpace;
    self.flowLayout.minimumInteritemSpacing = itemSpace;
}

-(void)setLineSpace:(CGFloat)lineSpace
{
    if (_lineSpace == lineSpace) {
        return;
    }
    _lineSpace = lineSpace;
    self.flowLayout.minimumLineSpacing = lineSpace;
}

@end
