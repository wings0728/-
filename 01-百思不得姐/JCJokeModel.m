//
//  JCJokeModel.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCJokeModel.h"

@implementation JCJokeModel
{
    CGFloat _cellHeight;
}


-(CGFloat)cellHeight{
    if (!_cellHeight) {
        //正文高度
        CGFloat textY = JCCellIconH + JCCellMarginY;
        NSDictionary *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * JCCellMarginX - 2 * JCCellTextMarginW, MAXFLOAT);
        CGRect textF = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
        
        CGFloat cellHeight = textF.size.height + textY + JCCellButtonViewH + 3 * JCCellMarginH;
        //图片高度
        if (self.type == JCTableViewTypePicture) {
            //图片frame计算
            CGFloat imageX = JCCellMarginX;
            CGFloat imageY = textF.size.height + textY + JCCellMarginY;
            CGFloat imageW = textSize.width;
            CGFloat imageH = self.height * ( imageW / self.width);
            if (imageH > JCCellImageTooBigH) {
                //判断是否超大图
                imageH = JCCellMaxImageH;
                self.tooBigImage = YES;
            }
            //设置图片frame
            self.imageF = CGRectMake(imageX, imageY, imageW, imageH);
            //cell高度
            cellHeight = imageH + imageY + JCCellMarginY + JCCellButtonViewH + JCCellMarginH;
            
        }else if (self.type == JCTableViewTypeVoice){
            //声音图片frame计算
            CGFloat voiceX = JCCellMarginX;
            CGFloat voiceY = textF.size.height + textY + JCCellMarginY;
            CGFloat voiceW = textSize.width;
            CGFloat voiceH = self.height * ( voiceW / self.width);
            self.voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            //cell高度
            cellHeight = voiceH + voiceY + JCCellMarginY + JCCellButtonViewH + JCCellMarginH;
        }
        _cellHeight = cellHeight;
    }
    return _cellHeight;
}

-(void)setDing:(NSString *)ding{
    _ding = ding;
    if (!ding) {
        _ding = @"顶一下";
    }
}

-(void)setCai:(NSString *)cai{
    _cai = cai;
    if (!cai) {
        _cai = @"踩一踩";
    }
}

-(void)setRepost:(NSString *)repost{
    _repost = repost;
    if (!repost) {
        _repost = @"来一条";
    }
}

-(void)setFavourite:(NSString *)favourite{
    _favourite = favourite;
    if (!favourite) {
        _favourite = @"分享下";
    }
}

@end
