//
//  PlanAccountView.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "IMUserProtocol.h"
//#include <objc/objc-class.h>
#include "IMUserProtocol.h"
@class PlanAccountView;
@protocol DFCAccountDelegate <NSObject>
@optional
- (void)didSelectRowAtIndexPath:(PlanAccountView*)didSelectRowAtIndexPath IndexPath:(NSInteger)IndexPath;
@end


@interface PlanAccountView : UIView<IMUserProtocol>
@property (nonatomic,weak)id<DFCAccountDelegate>delegate;
@end
