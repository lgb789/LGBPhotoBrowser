//
//  LGBPhotoBrowser.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/5/3.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPhotoBrowser.h"


#define Identifier         @"Identifier"
#define kAnimationDuration 0.3

static NSString * const kFrameKey = @"frame";

@interface LGBPhotoBrowser () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL isRotate;
@property (nonatomic, assign) BOOL firstShow;
@property (nonatomic, assign) BOOL dismissing;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation LGBPhotoBrowser

#pragma mark - *********************** public methods ***********************
-(void)setData:(NSArray *)data
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:data];
    
    self.pageControl.numberOfPages = self.items.count;
}

-(void)showItem:(NSUInteger)item
{
    self.currentPage = item;
    self.firstShow = YES;
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    [window addObserver:self forKeyPath:kFrameKey options:NSKeyValueObservingOptionNew context:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)registerCellClass:(Class)cellClass
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:Identifier];
}

#pragma mark - *********************** overwrite methods ***********************

-(void)dealloc
{
//    DLog(@"dealloc");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window removeObserver:self forKeyPath:kFrameKey];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemSpace = 50;
        [self addSubview:self.collectionView];
//        [self.collectionView registerClass:[LGBPhotoBrowserCell class] forCellWithReuseIdentifier:Identifier];
        
        [self addSubview:self.pageControl];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds) + self.itemSpace, CGRectGetHeight(self.bounds));
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) + self.itemSpace, CGRectGetHeight(self.bounds));
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    self.pageControl.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) * 0.95);
    
//    DLog(@"self frame:%@,%@,%@,%@", NSStringFromCGRect(self.frame), NSStringFromCGSize(self.collectionView.contentSize), NSStringFromCGRect(self.collectionView.frame), NSStringFromCGSize(self.flowLayout.itemSize));

    if (self.isRotate) {
        [self cleanZoom];
        self.isRotate = NO;
    }
    
}

#pragma mark - *********************** delegate ***********************

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGBPhotoBrowserCell *c = (LGBPhotoBrowserCell *)cell;
    LGBPhotoModel *model = self.items[indexPath.item];
    CGRect rect = [self convertRect:model.smallImageView.frame fromView:model.smallImageView];
//    DLog(@"rect--->%@,%@", NSStringFromCGRect(rect), NSStringFromCGRect(cell.frame));

    if (self.firstShow) {
        [self.pageControl setCurrentPage:indexPath.item];
        self.firstShow = NO;
        c.imageView.frame = rect;
        c.imageView.imageView.frame = c.imageView.bounds;
        
        [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [c configCellWithData:model];
            [c setNeedsLayout];
            [c layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [c configCellWithData:model];
        [c setNeedsLayout];
        [c layoutIfNeeded];
    }
    
    
    if (c.singleTap == nil) {
        __weak typeof(self) weakSelf = self;
        c.singleTap = ^(void){
           
            [weakSelf dismiss];
            
        };
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isRotate) {
        return;
    }
    CGFloat scrollWidth = CGRectGetWidth(scrollView.bounds);
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    int page = (currentOffsetX + scrollWidth / 2) / scrollWidth;
//    DLog(@"page-->%d,%f,%f", page,currentOffsetX, scrollWidth);
    if (self.currentPage != page) {
        [self cleanZoom];
        self.currentPage = page;
        [self.pageControl setCurrentPage:page];
    }
    
}

#pragma mark - *********************** event response ***********************

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIView *)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (![keyPath isEqualToString:kFrameKey]) {
        return;
    }
    self.isRotate = YES;
    self.frame = object.bounds;
//    DLog(@"frame change----->");
}

#pragma mark - *********************** private methods ***********************

-(void)cleanZoom
{
    LGBPhotoBrowserCell *cell = (LGBPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0]];
    [cell cleanZoom];
}

-(void)dismiss
{
    if (self.dismissing) {
        return;
    }
    self.dismissing = YES;
    LGBPhotoModel *model = self.items[self.currentPage];
    CGRect rect = [model.smallImageView.superview convertRect:model.smallImageView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    LGBPhotoBrowserCell *cell = (LGBPhotoBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentPage inSection:0]];
    
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.pageControl.alpha = 0;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cell.imageView.frame = rect;
        cell.imageView.imageView.frame = cell.imageView.bounds;
        self.collectionView.backgroundColor = [UIColor clearColor];

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - *********************** getters and setters ***********************
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

-(NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
