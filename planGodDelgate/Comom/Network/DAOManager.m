//
//  DAOManager.m
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/9.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "DAOManager.h"
static DAOManager *dataManager = nil;
@interface DAOManager ()
@end

@implementation DAOManager

+ (id)allocWithZone:(NSZone *)zone{
    return [self sharedInstanceDataDAO];
}

+(instancetype)sharedInstanceDataDAO{
    static dispatch_once_t dispatch;
    dispatch_once(&dispatch , ^{
        if (dataManager==nil) {
            //保证唯一实例化对象
            dataManager = [[super allocWithZone:NULL] init];
        }
    });return dataManager;
}

-(NSMutableArray*)arrayManager{
    if (!_arrayManager) {
        _arrayManager=[[NSMutableArray alloc]init];
    }return _arrayManager;
}

-(NSMutableArray*)searcManager{
    if (!_searcManager) {
        _searcManager=[[NSMutableArray alloc]init];
    }return _searcManager;
}

-(NSMutableArray*)shopCarManager{
    if (!_shopCarManager) {
        _shopCarManager=[[NSMutableArray alloc]init];
    }return _shopCarManager;
}

-(void)shopCarManager:(GoodModel *)model{
    [_shopCarManager addObject:model];
}
-(void)saveSearcManager:(GoodModel *)model{
    [_searcManager addObject:model];
}

-(void)saveArrayManager:(GoodModel *)model{
    [_arrayManager addObject:model];
}
-(void)clearDataManager{
    [_searcManager removeAllObjects];
    [_shopCarManager removeAllObjects];
}

@end
