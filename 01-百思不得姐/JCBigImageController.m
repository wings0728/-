//
//  JCBigImageController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/27.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCBigImageController.h"
#import <UIImageView+WebCache.h>
#import "JCJokeModel.h"

@interface JCBigImageController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation JCBigImageController
//懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置控制器背景色
    self.view.backgroundColor = [UIColor blackColor];
    //添加左上返回按钮
    [self setupBackBtn];
    [self setupImageView];
}
/**
 *  设置图片
 */
-(void)setupImageView{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1]];
    self.imageView.height = self.model.height * (JCScreenWidth / self.model.width);
    self.imageView.width = JCScreenWidth;
    self.imageView.x = 0;
    if (self.imageView.height < JCScreenHeight) {//如果图片高度小于屏幕高度，就让他居中
        self.imageView.y = (JCScreenHeight - self.imageView.height) * 0.5;
        //把imageView加入view
        [self.view addSubview:self.imageView];
    }else{//如果图片太长，则加一个scrollView
        [self setupScrollView];
    }
//    NSLog(@"%@",self.imageView);
}
/**
 *  初始化scrollView
 */
-(void)setupScrollView{
    UIScrollView *imageScrollView = [[UIScrollView alloc] init];
    //设置scrollView尺寸
    imageScrollView.frame = JCScreen;
    //设置背景色
    imageScrollView.backgroundColor = [UIColor clearColor];
    //设置contentSize
    imageScrollView.contentSize = CGSizeMake(0, self.imageView.height);
    //把imageView加到scrollView里
    [imageScrollView addSubview:self.imageView];
    //把scrollView加到view里
    [self.view insertSubview:imageScrollView atIndex:0];
}
/**
 * 添加左上返回按钮
 */
-(void)setupBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
    //设置frame
    CGFloat backX = 10;
    CGFloat backY = 30;
    CGFloat backW = backBtn.currentBackgroundImage.size.width;
    CGFloat backH = backBtn.currentBackgroundImage.size.height;
    backBtn.frame = CGRectMake(backX, backY, backW, backH);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
/**
 *  退出控制器
 */
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"1");
    [self backClick];
}

@end
