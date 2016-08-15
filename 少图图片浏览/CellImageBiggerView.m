//
//  CellImageBiggerView.m
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

#import "CellImageBiggerView.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height

@interface CellImageBiggerView ()<UIScrollViewDelegate>
/**
 *  顶部View
 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  图片计数文本框
 */
@property (weak, nonatomic) IBOutlet UILabel *countL;

/**
 *  显示图片的大滑动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
/**
 *  底部的View
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) UIView *backView;

/**
 *  所有的图片视图
 */
@property (strong, nonatomic) NSMutableArray *imgVs;
/**
 *  每个分页中滑动视图数组
 */
@property (strong, nonatomic) NSMutableArray *scrolls;
@end

@implementation CellImageBiggerView

- (void)awakeFromNib
{
    
}

+ (instancetype)creatImageBiggerView
{
    CellImageBiggerView *view = [[[NSBundle mainBundle] loadNibNamed:@"CellImageBiggerView" owner:nil options:nil] firstObject];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(close)];
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(close)];
    [view.topView addGestureRecognizer:tap1];
    [view.bottomView addGestureRecognizer:tap];
    view.scrollV.showsHorizontalScrollIndicator = NO;
    view.scrollV.pagingEnabled = YES;
    view.scrollV.delegate = view;
    return view;
}
- (void)show
{
    self.countL.text = [NSString stringWithFormat:@"%ld/%ld", self.startIndex+1, self.images.count];
    UIView *parent = [UIApplication sharedApplication].keyWindow;
    UIView *back = [[UIView alloc]initWithFrame:parent.bounds];
    back.backgroundColor = [UIColor blackColor];
    back.alpha = 0.0;
    self.backView = back;
    [parent addSubview:self.backView];
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [parent addSubview:self];
    
    [UIView  animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight);
        back.alpha = 0.3;
    }];
}
- (void)close
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(0,kScreenHeight, kScreenWidth,kScreenHeight);
        self.backView.alpha=0.0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (NSMutableArray *)imgVs
{
    if (_imgVs == nil) {
        _imgVs = [[NSMutableArray alloc] init];
    }
    return _imgVs;
}
- (NSMutableArray *)scrolls
{
    if (_scrolls == nil) {
        _scrolls = [[NSMutableArray alloc] init];
    }
    return _scrolls;
}
- (void)setImages:(NSArray *)images
{
    _images = images;
    CGFloat y = 0;
    CGFloat w = kScreenWidth;
    CGFloat h = w;
    [self.imgVs removeAllObjects];
    // 根据图片个数，创建等数的imageView,并且添加到数组中去（imgvs）
    // 大scrollView的每一页都是一个小的scrollView， 小的scrollView中在添加imageView
    // 将小的scrollView添加到数组中（scrolls）
    for (int i = 0; i < images.count; i++) {
        NSString *imgUrl = [images objectAtIndex:i];
        CGFloat x = i * w;
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scroll.frame = CGRectMake(x, y, w, h);
        UIImageView *imgV = [[UIImageView alloc] init];
        [self.imgVs addObject:imgV];
        [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"pic1"]];
        imgV.frame = scroll.bounds;
        [scroll addSubview:imgV];
        
        scroll.contentSize = imgV.frame.size;
        scroll.delegate = self;
        scroll.maximumZoomScale = 3.0;
        scroll.minimumZoomScale = 1.0;
        [self.scrollV addSubview:scroll];
        [self.scrolls addObject:scroll];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [scroll addGestureRecognizer:singleTap];
        [scroll addGestureRecognizer:doubleTap];
    }
    // 设置起始位置
    self.scrollV.contentSize = CGSizeMake(kScreenWidth * images.count, 0);
}

- (void)setStartIndex:(NSInteger)startIndex
{
    _startIndex = startIndex;
    self.scrollV.contentOffset = CGPointMake(kScreenWidth * startIndex, 0);
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    
    CGPoint point = self.scrollV.contentOffset;
    NSInteger index = point.x / kScreenWidth;
    UIScrollView *scrollView = [self.scrolls objectAtIndex:index];
    
    if (scrollView.zoomScale > 1.0f) {
        [scrollView setZoomScale:1.0 animated:YES];
    }else {
        CGPoint touchPoint = [doubleTap locationInView:scrollView];
        CGFloat newZoomScale = scrollView.maximumZoomScale * 2;
//        CGFloat newZoomScale = 6.0;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)doubleTap {
    [self close];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollV) {
        return nil;
    }
    CGPoint point = self.scrollV.contentOffset;
    NSInteger index = point.x / kScreenWidth;
    return [self.imgVs objectAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollV) {
        CGFloat scrollW = scrollView.frame.size.width;
        NSInteger page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
        self.countL.text = [NSString stringWithFormat:@"%ld/%ld", page+1, self.images.count];
    }
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView != self.scrollV) {
        CGPoint point = self.scrollV.contentOffset;
        NSInteger index = point.x / kScreenWidth;
        UIScrollView *scroll = [self.scrolls objectAtIndex:index];
        UIImageView *img = [self.imgVs objectAtIndex:index];
        CGFloat offsetX = (scroll.bounds.size.width >scroll.contentSize.width)?
        (scroll.bounds.size.width - scroll.contentSize.width) * 0.5: 0.0;
        CGFloat offsetY = (scroll.bounds.size.height >scroll.contentSize.height)?
        (scroll.bounds.size.height - scroll.contentSize.height) *0.5 : 0.0;
        img.center = CGPointMake(scroll.contentSize.width * 0.5 +offsetX,scroll.contentSize.height * 0.5 + offsetY);
    }
    
}

@end
