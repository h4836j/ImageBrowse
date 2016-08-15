//
//  CellImageBiggerView.h
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//  点击图片放大的View

#import <UIKit/UIKit.h>

@interface CellImageBiggerView : UIView

+ (instancetype)creatImageBiggerView;
/**
 *  需要显示的图片数组
 */
@property (strong, nonatomic) NSArray *images;
/**
 *  显示的第一张图片的索引
 */
@property (assign, nonatomic) NSInteger startIndex;
- (void)show;
@end
