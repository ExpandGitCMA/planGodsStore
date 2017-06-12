//
//  NSCopyModel.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/12.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCopyModel : NSObject<NSCopying>
@property(nonatomic,copy)NSString *name;
@end
