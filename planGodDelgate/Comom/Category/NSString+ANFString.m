//
//  NSString+ANFString.m
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/12.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NSString+ANFString.h"
#import <objc/runtime.h>

@implementation NSString (ANFString)
static int _intFlag;
static NSString *_strFlag;

- (void)setStrFlag:(NSString *)flag {
    // void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, &_strFlag, flag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark-获取相关联的对象 objc_getAssociatedObject
- (NSString *)strFlag {
    // id objc_getAssociatedObject(id object, const void *key)
    return objc_getAssociatedObject(self, &_strFlag);
}

#pragma mark-断开关联 objc_setAssociatedObject
- (void)setIntFlag:(int)intFlag {
    NSNumber *t = @(intFlag);
    // void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, &_intFlag, t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (int)intFlag {
    // id objc_getAssociatedObject(id object, const void *key)
    NSNumber *t = objc_getAssociatedObject(self, &_intFlag);
    return (int)[t integerValue];
}
@end
