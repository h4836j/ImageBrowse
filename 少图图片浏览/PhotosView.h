//
//  PhotosView.h
//  少图图片浏览
//
//  Created by huju on 16/6/27.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView
/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *images;
/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
