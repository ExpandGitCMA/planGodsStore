//
//  DAOManager.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/9.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodModel.h"
@interface DAOManager : NSObject
@property(nonatomic,strong)NSMutableArray*arrayManager;
@property(nonatomic,strong)NSMutableArray*searcManager;
@property(nonatomic,strong)NSMutableArray*shopCarManager;
+(instancetype)sharedInstanceDataDAO;
-(void)saveSearcManager:(GoodModel*)model;
-(void)saveArrayManager:(GoodModel*)model;
-(void)shopCarManager:(GoodModel*)model;
-(void)clearDataManager;
@end
