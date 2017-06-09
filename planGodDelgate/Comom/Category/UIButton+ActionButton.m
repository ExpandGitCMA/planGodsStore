//
//  UIButton+ActionButton.m
//  planGodDelgate
//  使用runtime 的属性实现类扩展创建UIButton事件
//  Created by ZeroSmile on 2017/6/9.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "UIButton+ActionButton.h"
#import <objc/runtime.h>



@implementation UIButton (ActionButton)

static NSString *keyOfMethod;
static NSString *keyOfBlock;

@dynamic actionBlock;

/*
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 id object                     :表示关联者，是一个对象，变量名理所当然也是object
 const void *key               :获取被关联者的索引key
 id value                      :被关联者，这里是一个block
 objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 注意这里面我声明了两个索引KEY；
 */
+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock{
    UIButton *button = [[UIButton alloc]init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject (button , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return button;
}

- (void)buttonClick:(UIButton *)button{
    
    //通过key获取被关联对象
    //objc_getAssociatedObject(id object, const void *key)
    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(button, &keyOfMethod);
    if(block1){
        block1(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyOfBlock);
    if(block2){
        block2(button);
    }
}

- (void)setActionBlock:(ActionBlock)actionBlock{
    objc_setAssociatedObject (self, &keyOfBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
}

- (ActionBlock)actionBlock{
    return objc_getAssociatedObject (self ,&keyOfBlock);
}
@end
