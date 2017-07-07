//
//  NSDateComponentsObject.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/6.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSDateComponentsObject.h"

static NSDateComponentsObject *componentsObject = nil;

@implementation NSDateComponentsObject

- (id)copyWithZone:(NSZone *)zone {
    return [[NSDateComponentsObject allocWithZone:zone] init];
}

+ (id)allocWithZone:(NSZone *)zone{
    return [self shareComponentsObject];
}

+(NSDateComponentsObject *)shareComponentsObject{
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch, ^{
        componentsObject = [[super allocWithZone:NULL] init];
    });
    return componentsObject;
}

/*
 *@计算当前系统时间
 *@ Day 2016.11.26
 */
-(NSDateComponents*)getNonceComponents{
    
    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit fromDate:date];
    return components;
}

-(NSInteger)nowayear{
  
    
    NSInteger year = [[self getNonceComponents]year];
    return year;
}
-(NSInteger)nowamonth{
    NSInteger month = [[self getNonceComponents]month];
    return month;
}
-(NSInteger)nowaday{
    NSInteger day = [[self getNonceComponents]day];
    return day;
}
-(NSInteger)nowahour{
    NSInteger hour = [[self getNonceComponents]hour];
    return hour;
}
-(NSInteger)nowaminute{
    NSInteger minute = [[self getNonceComponents]minute];
    return minute;
}
-(NSInteger)nowasecond{
    NSInteger second = [[self getNonceComponents]second];
    return second;
}

/*
 *@当前星期几
 */
-(NSInteger)nowaweekday{
    NSInteger weekday = [[self getNonceComponents]weekday]-1;
    return weekday;
}
/*
 *@当前周是在当月的第几周
 */
-(NSInteger)nowaweekdayOrdinal{
    NSInteger weekdayOrdinal = [[self getNonceComponents]weekdayOrdinal];
    return weekdayOrdinal;
}
/*
 *@当前今年的第几周
 */
-(NSInteger)nowaweek{
    NSInteger week = [[self getNonceComponents]week];
    return week;
}

@end
