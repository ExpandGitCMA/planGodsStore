//
//  DFCHotSearch.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/9.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFCHotSearch;

@protocol  DFCHotSearchDelegate<NSObject>
@optional
-(void)topHotSearch:(DFCHotSearch*)topHotSearch hotSearchStr:(NSString *)hotSearchStr;

@end


@interface DFCHotSearch : UIView
+(DFCHotSearch*)initWithDFCHotSearchFrame:(CGRect)frame delegate:(id<DFCHotSearchDelegate>)delgate;
@end
