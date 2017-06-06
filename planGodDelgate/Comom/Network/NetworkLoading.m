//
//  NetworkLoading.m
//  planGodDelgate
//
//  Created by ZeroSmell on 2017/4/7.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import "NetworkLoading.h"

@implementation NetworkLoading
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    
    return self;
}
-(void)initView{
    
   // self.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    NSMutableArray *array = [NSMutableArray array];
    UIImage *image;
    for (int i = 1; i < 6; i++) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"img_network_reload%d_160x160", i]];
        [array addObject:image];
    }
    
    _imgViewLoading = [[UIImageView alloc] init];
    _imgViewLoading.contentMode = UIViewContentModeCenter;
    _imgViewLoading.animationImages = array;
    _imgViewLoading.animationDuration = array.count * 0.35;
    //_imgViewLoading.center = [[UIApplication sharedApplication] windows].lastObject.center;
    _imgViewLoading.frame = CGRectMake((self.frame.size.width-image.size.width)/2, self.frame.size.height- 164, image.size.width, image.size.height);
    [self addSubview:_imgViewLoading];
    [_imgViewLoading startAnimating];
}

-(void)startLoading{
    [_imgViewLoading startAnimating];
    self.hidden = NO;
}

-(void)stopLoading{
    [_imgViewLoading stopAnimating];
    self.hidden = YES;
}
@end
