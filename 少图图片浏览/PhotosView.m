//
//  PhotosView.m
//  少图图片浏览
//
//  Created by huju on 16/6/27.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

//#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
//#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height


#import "PhotosView.h"
#import "UIImageView+WebCache.h"
#import "UpImage.h"
#import "CellImageBiggerView.h"
#import "UIView+Extension.h"

#define StatusPhotoWH ([[UIScreen mainScreen] bounds].size.width - 4)/ 3
#define StatusPhotoMargin 10
#define StatusPhotoMaxCol(count) ((count==4)?2:3)

@interface PhotosView ()

@end

@implementation PhotosView

- (void)setImages:(NSArray *)images
{
    _images = images;
    NSInteger count = images.count;
    // 当图片个数少于需要显示的个数时，创建一个视图
    while (self.subviews.count < count) {
        UpImage *photoView = [UpImage creatImageView];
        photoView.hiddenCloseBtn = YES;
        // 点击图片时放大图片
        [photoView tapImage:^(NSInteger index) {
            CellImageBiggerView *bigger = [CellImageBiggerView creatImageBiggerView];
            bigger.startIndex = index;
            bigger.images = self.images;
            [bigger show];
        }];
        [self addSubview:photoView];
        
    }
    
    for (int i = 0; i<self.subviews.count; i++) {
        UpImage *photoView = self.subviews[i];
        if (i < count) {
            photoView.hidden = NO;
            NSString *url = [images objectAtIndex:i];
            photoView.index = i;
            [photoView.imgV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        } else {
            photoView.hidden = YES;
        }
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.images.count;
    int maxCol = StatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        UpImage *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (StatusPhotoWH + StatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (StatusPhotoWH + StatusPhotoMargin);
        photoView.width = StatusPhotoWH;
        photoView.height = StatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = StatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * StatusPhotoWH + (cols - 1) * StatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * StatusPhotoWH + (rows - 1) * StatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
