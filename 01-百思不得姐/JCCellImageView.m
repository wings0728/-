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

@interface JCCellImageView()

@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end

@implementation JCCellImageView

+(instancetype)cellImageView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setModel:(JCJokeModel *)model{
    _model = model;
    //设置图片
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    if (!model.is_gif) {
        self.gifImage.hidden = YES;
    }
}

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
