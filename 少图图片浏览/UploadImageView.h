//
//  UploadImageView.h
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//  上传图片的整体View

#import <UIKit/UIKit.h>
typedef void(^clinkBlock)(NSInteger index);
@interface UploadImageView : UIView
/**
 *  可滑动的图片View
 */
@property (strong, nonatomic) UIScrollView *imageContainView;
/**
 *  需要上传的图片数组
 */
@property (strong, nonatomic) NSArray *images;
/**
 *  删除选中的图片
 */
- (void)deleteImgClink:(clinkBlock)clink;
@end
