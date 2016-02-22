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
    
}
//加载模型
-(void)setModel:(JCJokeModel *)model{
    _model = model;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = model.screen_name;
    self.createdDate.text = model.create_time;
    self.textLable.text = model.text;
    [self.dingBtn setTitle:model.ding forState:UIControlStateNormal];
    [self.caiBtn setTitle:model.cai forState:UIControlStateNormal];
    [self.shareBtn setTitle:model.favourite forState:UIControlStateNormal];
    [self.messageBtn setTitle:model.repost forState:UIControlStateNormal];
}
//设置高度
-(CGFloat)setCellHeight{
    NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    self.textLable.frame = [self.textLable.text boundingRectWithSize:CGSizeMake(self.textLable.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
//    CGFloat cellHeight = self.textLable.height + self.icon.height + self.dingBtn.height + 20;
    NSLog(@"%f",self.height);
    return self.height;
}
@end
