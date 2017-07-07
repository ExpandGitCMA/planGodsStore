//
//  DFCGodLaunchVC.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明block回调
typedef void(^MainQueueBlock)(id obj );

@interface DFCGodLaunchVC : UIViewController
@property (nonatomic, copy) NSString *adUrl;
@property (nonatomic,copy) MainQueueBlock block;
@end
