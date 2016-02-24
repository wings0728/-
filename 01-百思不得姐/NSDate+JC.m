//
//  NSDate+JC.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/23.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "NSDate+JC.h"

@implementation NSDate (JC)
/**
 *  判断传入时间是否为今天
 */
-(BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *createDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:createDate toDate:nowDate options:NSCalendarWrapComponents];
    return cmps.day == 0 && cmps.year == 0 && cmps.month == 0;
}
/**
 *  判断传入时间是否为今年
 */
-(BOOL)isThisYear{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSComparisonResult result = [calendar compareDate:self toDate:nowDate toUnitGranularity:NSCalendarUnitYear];
    return result == 0;
}
/**
 *  判断传入时间是否为昨天
 */
-(BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *createDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:createDate toDate:nowDate options:NSCalendarWrapComponents];
    return cmps.day == 1 && cmps.year == 0 && cmps.month == 0;
}
/**
 *  比较两个时间小时的差值
 */
-(NSInteger)deltaHours:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:self options:0];
    return cmps.hour;
}
-(NSInteger)deltaMinutes:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:self options:0];
    return cmps.minute;
}
-(NSInteger)deltaSeconds:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:self options:0];
    return cmps.second;
}

@end
