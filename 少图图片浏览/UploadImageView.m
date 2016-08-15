//
//  UploadImageView.m
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

#import "UploadImageView.h"
#import "UpImage.h"

@interface UploadImageView ()


@property (copy, nonatomic) clinkBlock clinked;

@end

@implementation UploadImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        [self addSubview:scroll];
    }
    return self;
    
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    NSInteger count = images.count;
    
    // 当图片个数少于需要显示的个数时，创建一个视图
    while (self.imageContainView.subviews.count < count) {
        UpImage *photoView = [UpImage creatImageView];
        [photoView closeBtnClink:^(NSInteger index) {
            if (self.clinked) {
                self.clinked(index);
            }
        }];
        [self.imageContainView addSubview:photoView];
    }
    
    // 便利已有的图片视图，控制视图的显示和隐藏
    for (int i = 0; i<self.subviews.count; i++) {
        UpImage *photoView = self.imageContainView.subviews[i];
        if (i < count) {
            photoView.hidden = NO;
            photoView.img = [images objectAtIndex:i];
            photoView.index = i;
        } else {
            photoView.hidden = YES;
        }
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageContainView.frame = self.bounds;
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.images.count;
    CGFloat imgY = 0;
    CGFloat imgH = 50;
    CGFloat imgW = 50;
    CGFloat margin = 10;
    for (int i = 0; i < photosCount; i++) {
        UpImage *imgV = self.imageContainView.subviews[i];
        CGFloat imgX = i * (imgW + margin);
        imgV.frame = CGRectMake(imgX, imgY, imgW, imgH);
    }
}

- (void)deleteImgClink:(clinkBlock)clink
{
    self.clinked = clink;
}

@end
