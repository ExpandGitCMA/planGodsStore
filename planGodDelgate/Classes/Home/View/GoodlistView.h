//
//  GoodlistView.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodlistView;

@protocol  GoodlistDelegate <NSObject>
@optional
-(void)loadView:(GoodlistView*)loadView   message:(NSString*)message;
-(void)flashsale:(GoodlistView*)flashsale message:(NSInteger)message;
@end

@interface GoodlistView : UIView
@property(nonatomic,weak) id<GoodlistDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame arraySource:(NSArray *)arraySource;
-(void)tableViewRefresh;
@end
