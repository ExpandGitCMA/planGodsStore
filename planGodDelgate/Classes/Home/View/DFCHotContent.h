//
//  DFCHotContent.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DFCHotContent;

@protocol  HotContentDelegate <NSObject>
@optional
-(void)selectStatus:(DFCHotContent*)selectStatus  page:(NSInteger)page;
@end
@interface DFCHotContent : UIView
@property(nonatomic,weak) id<HotContentDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame HotSearch:(NSArray*)hotSearch;
@end
