//
//  GoodlistCell.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"

@interface GoodlistCell : UITableViewCell
-(void)setGoodModel:(GoodModel*)model;
@property (weak, nonatomic) IBOutlet UILabel *price;
@end
