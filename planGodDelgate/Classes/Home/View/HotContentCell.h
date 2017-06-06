//
//  HotContentCell.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/10/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotContentCell : UICollectionViewCell
@property(nonatomic,strong)UILabel*titleLabel;
-(void)setSelectCell:(BOOL)isSelect;
- (CGSize)sizeForCell:(NSString*)title;
@end
