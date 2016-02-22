//
//  JCTabBar.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCTabBar.h"

@interface JCTabBar()

@property (weak, nonatomic) UIButton *btn;

@end

@implementation JCTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化center的按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:btn];
        self.btn = btn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置center的frame
    CGFloat btnX = self.frame.size.width * 0.5 - self.btn.frame.size.width * 0.5;
    CGFloat btnY = self.frame.size.height * 0.5 - self.btn.frame.size.height * 0.5;
    CGFloat btnW = self.btn.currentBackgroundImage.size.width;
    CGFloat btnH = self.btn.currentBackgroundImage.size.height;
    self.btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    //设置其余4个按钮的位置
    CGFloat itemY = 0;
    CGFloat itemW = self.frame.size.width / 5;
    CGFloat itemH = self.frame.size.height;
    NSInteger index = 0;
    for (UIControl *item in self.subviews) {
        if (![item isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat itemX = (index > 1 ? index + 1 : index )* itemW;
        item.frame = CGRectMake(itemX, itemY, itemW, itemH);
        index++;
    }
}

@end
