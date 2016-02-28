//
//  JCPublishController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/28.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCPublishController.h"
#import "JCPublishButton.h"
#import <POP.h>

static CGFloat const JCPOPSpring = 10;
static CGFloat const JCPOPBegin = 0.1;

@interface JCPublishController ()
- (IBAction)dismissButton;

@end

@implementation JCPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置起始用户交互为不可用
    self.view.userInteractionEnabled = NO;
    
    [self setupButton];
}

-(void)setupButton{
    //设置按钮位置
    NSInteger lineCount = 2;//行数
    NSInteger columnCount = JCPublishButtonCount / lineCount;//列数
    //创建数组，放入图片名称
    NSArray *imageNameArr = @[@"video",@"picture",@"text",@"audio",@"review",@"offline"];
    //创建数组，放入按钮名称
    NSArray *btnNameArr = @[@"发视频",@"发图片",@"发段子",@"发视频",@"审帖",@"离线下载"];
    for (int index = 0; index < JCPublishButtonCount; index++) {
        //列号
        NSInteger column = index % columnCount;
        //行号
        NSInteger line = index / columnCount;
        //创建按钮
        JCPublishButton *publishBtn = [JCPublishButton buttonWithType:UIButtonTypeCustom];
        //设置图片
        NSString *imageName = [NSString stringWithFormat:@"publish-%@",imageNameArr[index]];
        [publishBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        publishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        publishBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置按钮title
        [publishBtn setTitle:btnNameArr[index] forState:UIControlStateNormal];
        //加入view
        [self.view addSubview:publishBtn];
        
        //设置frame
        CGFloat publishBtnW = publishBtn.currentImage.size.width;
        CGFloat publishBtnH = publishBtn.currentImage.size.height + 20;
        CGFloat margin = (JCScreenWidth - columnCount * publishBtnW) / (columnCount + 1);
        CGFloat publishBtnX = margin + column * (margin + publishBtnW);
        CGFloat publishBtnY = line * (publishBtnH + 20) + JCScreenHeight * 0.3;
        
        //创建pop动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //进行动画
        CGFloat publishBeginY = publishBtnY - JCScreenHeight;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(publishBtnX, publishBeginY, publishBtnW, publishBtnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(publishBtnX, publishBtnY, publishBtnW, publishBtnH)];
        anim.beginTime = CACurrentMediaTime() + JCPOPBegin * index;
        anim.springBounciness = JCPOPSpring;
        anim.springSpeed = JCPOPSpring;
        //加入动画
        [publishBtn pop_addAnimation:anim forKey:nil];
    }
    
    //设置图片
    UIImageView *titleImage  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    //设置图片起始位置
    titleImage.centerX = JCScreenWidth * 0.5;
    titleImage.centerY = JCScreenHeight * 0.2 - JCScreenHeight;
    [self.view addSubview:titleImage];
    
    //创建pop动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    //设置动画位置
    CGFloat titleImageX = JCScreenWidth * 0.5;
    CGFloat titleImageY = JCScreenHeight * 0.2;
    CGFloat beginY = titleImageY - JCScreenHeight;
    //进行动画
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(titleImageX, beginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(titleImageX, titleImageY)];
    anim.beginTime = CACurrentMediaTime() + JCPOPBegin * 6;
    anim.springSpeed = JCPOPSpring;
    anim.springBounciness = JCPOPSpring;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        //动画结束后开启用户交互
        self.view.userInteractionEnabled = YES;
    }];
    //加入动画
    [titleImage pop_addAnimation:anim forKey:nil];
}


- (IBAction)dismissButton {
//    NSLog(@"%@",self.view.subviews);
    for (int index = 2; index < self.view.subviews.count; index++) {
        //取出目前便利到的控件
        UIView *currentView = self.view.subviews[index];
        //取出当前控件的center值
        CGFloat currentCenterX = currentView.centerX;
        CGFloat currentCenterY = currentView.centerY;
        //开始动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        //进行动画
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(currentCenterX, currentCenterY)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(currentCenterX, currentCenterY + JCScreenHeight)];
        anim.beginTime = CACurrentMediaTime() + JCPOPBegin * index;
        //如果时最后一个控件，则完成动画后退出当前控制器
        if (index == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        //加入动画
        [currentView pop_addAnimation:anim forKey:nil];
    }
}
@end
