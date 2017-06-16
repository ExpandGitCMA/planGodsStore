//
//  Person.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/28.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
//-(void)eatWithStr:(NSString *)str;
//-(void)eat;
// Person *p = [[Person alloc] init];
// 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
// 动态添加方法就不会报错 [p performSelector:@selector(eat)];
@end
