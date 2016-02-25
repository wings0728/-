//
//  JCJokeModel.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCJokeModel : NSObject
/** 头像 **/
@property (copy, nonatomic) NSString *profile_image;
/** 昵称 **/
@property (copy, nonatomic) NSString *screen_name;
/** 帖子时间 **/
@property (copy, nonatomic) NSString *create_time;
/** 正文 **/
@property (copy, nonatomic) NSString *text;
/** 顶数量 **/
@property (copy, nonatomic) NSString *ding;
/** 踩数量 **/
@property (copy, nonatomic) NSString *cai;
/** 转发数量 **/
@property (copy, nonatomic) NSString *favourite;
/** 评论数量 **/
@property (copy, nonatomic) NSString *repost;
/** 图片 **/
@property (copy, nonatomic) NSString *image0;
@property (copy, nonatomic) NSString *image1;
@property (copy, nonatomic) NSString *image2;
/** 图片高度 **/
@property (assign, nonatomic) CGFloat height;
/** 图片宽度 **/
@property (assign, nonatomic) CGFloat width;
/** 图片宽度 **/
@property (assign, nonatomic) CGRect imageF;
/** 图片gif判断 **/
@property (assign, nonatomic) BOOL is_gif;
/** 图片超大判断判断 **/
@property (assign, nonatomic,getter=isTooBigImage) BOOL tooBigImage;


/** 帖子类型 **/
@property (assign, nonatomic) JCTableViewType type;

@property (assign, nonatomic, readonly) CGFloat cellHeight;



@end
