//
//  NSDate+JC.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/23.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JC)

-(BOOL)isToday;
-(BOOL)isThisYear;
-(BOOL)isYesterday;

-(NSInteger)deltaHours:(NSDate *)date;
-(NSInteger)deltaMinutes:(NSDate *)date;
-(NSInteger)deltaSeconds:(NSDate *)date;

@end
