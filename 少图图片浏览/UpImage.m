//
//  UpImage.m
//  liuxiaoxin
//
//  Created by HJ on 16/4/19.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

#import "UpImage.h"

@interface UpImage ()
//{
//    closeBlock clinked;
//}

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (copy, nonatomic) closeBlock clinked;

@property (copy, nonatomic) tapBlock taped;

@end

@implementation UpImage

+(instancetype)creatImageView
{
    UpImage *img = [[[NSBundle mainBundle] loadNibNamed:@"UpImage" owner:nil options:nil] firstObject];
    img.hiddenCloseBtn = YES;
    
    
    return img;
}

- (void)awakeFromNib
{
    
    [self.closeBtn addTarget:self action:@selector(closeClink) forControlEvents:UIControlEventTouchUpInside];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self addGestureRecognizer:tap];
}


- (void)setImg:(UIImage *)img
{
    _img = img;
    self.imgV.image = img;
}

- (void)setHiddenCloseBtn:(BOOL)hiddenCloseBtn
{
    _hiddenCloseBtn = hiddenCloseBtn;
    self.closeBtn.hidden = hiddenCloseBtn;
}

- (void)tapImage:(tapBlock)tap
{
    self.taped = tap;
}

- (void)closeBtnClink:(closeBlock)clink
{
    self.clinked = clink;
}



- (void)closeClink
{
    if (self.clinked) {
        self.clinked(self.index);
    }
}
- (void)imageTap
{
    if (self.taped) {
        self.taped(self.index);
    }
}


@end
