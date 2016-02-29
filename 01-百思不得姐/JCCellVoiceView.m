//
//  JCCellVoiceView.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/29.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCCellVoiceView.h"
#import <UIImageView+WebCache.h>
#import "JCJokeModel.h"

@interface JCCellVoiceView()
/** 音频图片 **/
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
/** 音频播放次数 **/
@property (weak, nonatomic) IBOutlet UILabel *voiceCount;
/** 音频时长 **/
@property (weak, nonatomic) IBOutlet UILabel *voiceTime;
///** 按钮selected状态缓存 **/
//@property (weak, nonatomic) UIButton *selectedBtn;

@end

@implementation JCCellVoiceView
/**
 *  类方法加载xib文件
 */
+(instancetype)cellVoiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
/**
 *  懒加载
 */
//-(UIButton *)selectedBtn{
//    if (!_selectedBtn) {
//        UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _selectedBtn = selectedBtn;
//    }
//    return _selectedBtn;
//}

-(void)setModel:(JCJokeModel *)model{
    _model = model;
    //设置图片
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    //设置播放次数
    NSInteger playCount = model.playcount;
    if (playCount > 10000) {
        CGFloat count = playCount * 0.0001;
        self.voiceCount.text = [NSString stringWithFormat:@"播放%.1f万次",count];
    }else{
       self.voiceCount.text = [NSString stringWithFormat:@"播放%zd次",playCount];
    }
    //设置音频时长
    NSInteger min = model.voicetime / 60;
    NSInteger second = model.voicetime % 60;
    self.voiceTime.text = [NSString stringWithFormat:@"%02zd:%02zd",min, second];
    
}
/**
 *  点击play
 */
- (IBAction)playClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
