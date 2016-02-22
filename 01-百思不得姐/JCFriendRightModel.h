//
//  JCFriendRightModel.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/18.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCFriendRightModel : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end
