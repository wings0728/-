//
//  JCJokeModel.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCJokeModel : NSObject

@property (copy, nonatomic) NSString *profile_image;
@property (copy, nonatomic) NSString *screen_name;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *ding;
@property (copy, nonatomic) NSString *cai;
@property (copy, nonatomic) NSString *favourite;
@property (copy, nonatomic) NSString *repost;


+(instancetype)jokeModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
