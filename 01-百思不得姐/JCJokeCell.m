//
//  JCJokeCell.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCJokeCell.h"
#import "JCJokeModel.h"
#import <UIImageView+WebCache.h>
#import "JCCellImageView.h"
#import "JCCellVoiceView.h"
#import "JCCellVideoView.h"

@interface JCJokeCell()
/** 头像 **/
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/** 昵称 **/
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
/** 帖子时间 **/
@property (weak, nonatomic) IBOutlet UILabel *createdDate;
/** 正文 **/
@property (weak, nonatomic) IBOutlet UILabel *cellTextLable;
/** 顶按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/** 踩按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/** 分享按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
/** 图片view **/
@property (weak, nonatomic) JCCellImageView *cellImageView;
/** 声音图片view **/
@property (weak, nonatomic) JCCellVoiceView *cellVoiceView;
/** 视频图片view **/
@property (weak, nonatomic) JCCellVideoView *cellVideoView;

@end

@implementation JCJokeCell
/**
 *  懒加载图片view
 */
-(JCCellImageView *)cellImageView{
    if (!_cellImageView) {
        JCCellImageView *cellImageView = [JCCellImageView cellImageView];
        [self.contentView addSubview:cellImageView];
        _cellImageView = cellImageView;
    }
    return _cellImageView;
}
/**
 *  懒加载声音图片View
 */
-(JCCellVoiceView *)cellVoiceView{
    if (!_cellVoiceView) {
        JCCellVoiceView *cellVoiceView = [JCCellVoiceView cellVoiceView];
        [self.contentView addSubview:cellVoiceView];
        _cellVoiceView = cellVoiceView;
    }
    return _cellVoiceView;
}
/**
 *  懒加载视频图片View
 */
-(JCCellVideoView *)cellVideoView{
    if (!_cellVideoView) {
        JCCellVideoView *cellVideoView = [JCCellVideoView cellVideoView];
        [self.contentView addSubview:cellVideoView];
        _cellVideoView = cellVideoView;
    }
    return _cellVideoView;
}

- (void)awakeFromNib {
    // Initialization code
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
//加载模型,给各控件赋值
-(void)setModel:(JCJokeModel *)model{
    _model = model;
    //设置头像
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.nameLable.text = model.screen_name;
    //设置时间
    [self setupTimeLable:model];
    //设置正文
    self.cellTextLable.text = model.text;
    //设置按钮
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.shareBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.messageBtn setTitle:model.repost forState:UIControlStateNormal];
    //设置图片
    if (model.type == JCTableViewTypePicture) {
        //如果是图片
        self.cellImageView.hidden = NO;
        self.cellVoiceView.hidden = YES;
        self.cellVideoView.hidden = YES;
        self.cellImageView.model = model;
        self.cellImageView.frame = model.imageF;
    }else if (model.type == JCTableViewTypeVoice){
        //如果是声音
        self.cellImageView.hidden = YES;
        self.cellVoiceView.hidden = NO;
        self.cellVideoView.hidden = YES;
        self.cellVoiceView.model = model;
        self.cellVoiceView.frame = model.voiceF;
    }else if (model.type == JCTableViewTypeVideo){
        //如果是视频
        self.cellImageView.hidden = YES;
        self.cellVoiceView.hidden = YES;
        self.cellVideoView.hidden = NO;
        self.cellVideoView.model = model;
        self.cellVideoView.frame = model.videoF;
    }else{
        //如果是段子
        self.cellImageView.hidden = YES;
        self.cellVoiceView.hidden = YES;
        self.cellVideoView.hidden = YES;
    }
}

-(void)setupTimeLable:(JCJokeModel *)model{
    /**
     *  今年：
     今天：
     1分钟内：刚刚
     1小时内：xx分钟前
     其他：xx小时前
     昨天：昨天 HH:mm:ss
     其他：MM-dd HH:mm:ss
     非今年：yyyy-MM-dd HH:mm:ss
     */
    //拿到现在的时间
    NSDate *nowDate = [NSDate date];
    //拿到帖子时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:model.create_time];
    //比较日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:createDate toDate:nowDate options:NSCalendarWrapComponents];
    if (createDate.isThisYear) {//今年
        if (createDate.isToday) {//今天
            if (cmps.minute > 60) {//其他
                
                self.createdDate.text = [NSString stringWithFormat:@"%ld小时前",[nowDate deltaHours:createDate]];
            }else if(cmps.second >= 60){//1小时内
                self.createdDate.text = [NSString stringWithFormat:@"%ld分钟前",[nowDate deltaMinutes:createDate]];
            }else{//1分钟内
                self.createdDate.text = @"刚刚";
            }
        }else if (createDate.isYesterday){//昨天
            fmt.dateFormat = @"HH:mm:ss";
            self.createdDate.text = [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:createDate]];
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            self.createdDate.text = [fmt stringFromDate:createDate];
        }
    }else{//非今年
        self.createdDate.text = model.create_time;
    }
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = JCCellMarginX;
    frame.size.width -= 2 * JCCellMarginX;
    frame.origin.y += JCCellMarginY;
    frame.size.height -= JCCellMarginH;
    [super setFrame:frame];
}
@end
