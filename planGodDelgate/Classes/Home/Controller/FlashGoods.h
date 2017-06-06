//
//  FlashGoods.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/24.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlashGoods : UIView
-(instancetype)initWithFrame:(CGRect)frame count:(NSUInteger)count;
-(void)refresh;
@end
