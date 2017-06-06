//
//  HistoryArchive.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryArchive : NSObject
//保存NSDictionary 与归档
-(void)saveDictionary:(NSDictionary *)dict;
//解档得到NSDictionary
-(NSDictionary *)loadArchives;
@end
