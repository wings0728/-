//
//  JCCellImageView.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/25.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCCellImageView.h"
#import "JCJokeModel.h"
#import <UIImageView+WebCache.h>


@implementation JCCellImageView

+(instancetype)cellImageView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setModel:(JCJokeModel *)model{
    _model = model;
    //设置图片
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
//    NSLog(@"%@",model.image1);
//    NSLog(@"%@",NSStringFromCGRect(self.pictureView.frame));
}

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
