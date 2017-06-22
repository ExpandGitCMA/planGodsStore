//
//  UserView.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/16.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,SubkeyType) {
    SubkeyNome
};

typedef void(^HttpSucceedBlock)( BOOL ret, id obj  );

//声明block回调
typedef void(^SucceedBlock)(id obj );


//addTarget:(id)target action:(SEL)action

//com.dafenci.planByGodWin.text
@interface UserView : UIView
@property(nonatomic,assign)SubkeyType Key;
-(void)requestHttp:(HttpSucceedBlock)completedBlock;
@property (nonatomic,copy) SucceedBlock block;
@end
