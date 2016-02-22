//
//  JCFriendRightCell.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/18.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCFriendRightCell.h"
#import "JCFriendRightModel.h"
#import <UIImageView+WebCache.h>

@interface JCFriendRightCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *bottomLable;


@end

@implementation JCFriendRightCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(JCFriendRightModel *)model{
    _model = model;
    NSString *imageURL = _model.header;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    self.nameLable.text = _model.screen_name;
    self.bottomLable.text = [NSString stringWithFormat:@"%ld人关注",(long)_model.fans_count];
}

@end
