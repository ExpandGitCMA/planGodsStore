//
//  GoodFlashsaleCell.h
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/26.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^GoodGesBlock)(NSInteger  goodGes);

@interface GoodFlashsaleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (nonatomic,copy) GoodGesBlock goodGesBlock;
/** block :ARC使用strong  非ARC copy  声明一个block*/
@property(nonatomic,strong) void(^block)();
//外部回掉block方法
-(void)gesture:(void(^)(NSString *sender))block;
//外部事件添加方法
-(void)addTapGestureTarget:(id)target action:(SEL)action;
//外部事件代理回调

@end
