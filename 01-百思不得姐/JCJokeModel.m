//
//  JCJokeModel.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCJokeModel.h"

@implementation JCJokeModel

+(instancetype)jokeModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
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

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
