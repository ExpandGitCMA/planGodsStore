//
//  GeneralModel.h
//  planGodDelgate
//
//  Created by ZeroSmile on 2017/6/19.
//  Copyright © 2017年 DFC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define Goods_FetchCatFilterList @"/goods/fetchCatSkuList.do"  //类目过滤列表
#define Goods_GetRecommendGoods @"/goods/getGoodsDetailRecommend.do" // 获取商品详情页推荐商品

extern NSDictionary *GeneralModelClassMap();
extern NSDictionary *GeneralModelClassUrl();



@interface GeneralWithKeyValueNSString : NSObject

@end
