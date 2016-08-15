//
//  ViewController.m
//  少图图片浏览
//
//  Created by huju on 16/6/27.
//  Copyright © 2016年 liuxiaoxin. All rights reserved.
//

#import "ViewController.h"
#import "PhotosView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PhotosView *ptView = [[PhotosView alloc] init];
    NSArray *arr = @[@"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg", @"http://pic13.nipic.com/20110415/1369025_121513630398_2.jpg", @"http://image.tianjimedia.com/uploadImages/2015/129/56/J63MI042Z4P8.jpg", @"http://pic36.nipic.com/20131128/11748057_141932278338_2.jpg", @"http://pic6.nipic.com/20100413/1044396_090419160855_2.jpg", @"http://img4.imgtn.bdimg.com/it/u=788367407,1907680151&fm=21&gp=0.jpg", @"http://img3.duitang.com/uploads/item/201605/25/20160525093455_Qa2yR.thumb.700_0.jpeg"];
    CGSize size = [PhotosView sizeWithCount:arr.count];
    ptView.frame = CGRectMake(0, 100, size.width, size.height);
//    for (int i = 0; i<9; i++) {
//        NSString *str = [NSString stringWithFormat:@"pic%d.jpg", i];
//        [arr addObject:str];
//    }
    ptView.images = arr;
    
    [self.view addSubview:ptView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
