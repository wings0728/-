//
//  JCCellVideoView.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/29.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCCellVideoView.h"
#import <UIImageView+WebCache.h>
#import "JCJokeModel.h"

@interface JCCellVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLable;


@end

@implementation JCCellVideoView

/**
 *  类方法加载xib文件
 */
+(instancetype)cellVideoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setModel:(JCJokeModel *)model{
    _model = model;
    //设置图片
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    //设置播放次数
    NSInteger playCount = model.playcount;
    if (playCount > 10000) {
        CGFloat count = playCount * 0.0001;
        self.playCountLable.text = [NSString stringWithFormat:@"播放%.1f万次",count];
    }else{
        self.playCountLable.text = [NSString stringWithFormat:@"播放%zd次",playCount];
    }
    //设置音频时长
    NSInteger min = model.videotime / 60;
    NSInteger second = model.videotime % 60;
    self.playTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",min, second];
    
}
/**
 *  点击play
 */
- (IBAction)playClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
