//
//  UpImage.h
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//  最小的显示图片的单元控件

#import <UIKit/UIKit.h>
typedef void(^closeBlock)(NSInteger index);
typedef void(^tapBlock)(NSInteger index);
@interface UpImage : UIView
/** 是否隐藏关闭按钮 默认也YES*/
@property (assign, nonatomic, getter=isHiddenCloseBtn) BOOL hiddenCloseBtn;
/**
 *  显示的图片
 */
@property (strong, nonatomic) UIImage *img;
/**
 *  当前图片的位置索引
 */
@property (assign, nonatomic) NSInteger index;
/**
 *  显示图片的视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

+ (instancetype)creatImageView;
/**
 *  点击关闭按钮
 */
- (void)closeBtnClink:(closeBlock)clink;

- (void)tapImage:(tapBlock)tap;

@end
