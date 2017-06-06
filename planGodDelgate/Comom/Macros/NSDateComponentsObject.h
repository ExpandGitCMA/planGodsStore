//
//  NSDateComponentsObject.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/6.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponentsObject : NSObject
+(NSDateComponentsObject *)shareComponentsObject;
-(NSInteger)nowayear;
-(NSInteger)nowamonth;
-(NSInteger)nowaday;
-(NSInteger)nowahour;
-(NSInteger)nowaminute;
-(NSInteger)nowasecond;
/*
 *@当前星期几
 */
-(NSInteger)nowaweekday;
/*
 *@当前周是在当月的第几周
 */
-(NSInteger)nowaweekdayOrdinal;
/*
 *@当前今年的第几周
 */
-(NSInteger)nowaweek;
@end
