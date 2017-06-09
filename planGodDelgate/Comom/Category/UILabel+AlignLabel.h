//
//  UILabel+AlignLabel.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/9.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AlignLabel)

/**
 *  根据文本调整label的高度
 *  @param width 宽度限制
 *  @return 返回size大小
 */
-(CGSize)alignTopWithWidth:(CGFloat)width;
@end
