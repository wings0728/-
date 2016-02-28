//
//  JCPublishButton.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/28.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCPublishButton.h"

@implementation JCPublishButton
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.textColor = [UIColor blackColor];
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return self;
//}
/**
 *  自定义按钮image的frame
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.width;
    CGFloat imageH = imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
/**
 *  自定义按钮title的frame
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = self.width;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - self.width;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
