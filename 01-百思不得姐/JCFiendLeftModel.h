//
//  JCFiendLeftModel.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/18.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCFiendLeftModel : NSObject

@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *rightData;
/** 总页数 */
@property (nonatomic, assign) NSInteger total_page;
/** 当前页数 */
@property (nonatomic, assign) NSInteger next_page;

//+(instancetype)fiendLeftModelWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;

@end
