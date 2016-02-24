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

@interface JCJokeCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *createdDate;
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@end

@implementation JCJokeCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
//加载模型
-(void)setModel:(JCJokeModel *)model{
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = model.screen_name;
    [self setupTimeLable:model];
//    NSLog(@"是否今年：%d,是否今天：%d,是否昨天：%d",createDate.isThisYear,createDate.isToday,createDate.isYesterday);
    
    
    self.textLable.text = model.text;
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.shareBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.messageBtn setTitle:model.repost forState:UIControlStateNormal];
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

/**
 *  设置高度
 */
-(CGFloat)setCellHeight{
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * JCCellMarginX - 2 * JCCellTextMarginW, MAXFLOAT);
    self.textLable.frame = [self.textLable.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    CGFloat cellHeight = self.textLable.frame.size.height + JCCellIconH + JCCellButtonViewH + JCCellMarginH + JCCellMarginY;
    return cellHeight;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x = JCCellMarginX;
    frame.size.width -= 2 * JCCellMarginX;
    frame.origin.y += JCCellMarginY;
    frame.size.height -= JCCellMarginH;
    [super setFrame:frame];
}
@end
