//
//  NSString+ANFString.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/12.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ANFString)
// 对象属性的set和get
- (void)setStrFlag:(NSString *)strFlag;
- (NSString *)strFlag;

// 非对象属性的set和get
- (void)setIntFlag:(int)intFlag;
- (int)intFlag;
@end
