//
//  PlanColorDef.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/9/8.
//  Copyright © 2016年 DFC. All rights reserved.
//

#ifndef PlanColorDef_h
#define PlanColorDef_h

//RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define clang diagnostic ignored"-Wnonnull"

typedef NS_ENUM(UInt32, ColorRGBType) {
    DefaulColor       = 0xf2a0d5,
    SearchTypeColor   = 0x999999,
    EbebebColor       = 0xebebeb,
    LineColore        = 0xd6d6d6,
    BgGrayColore      = 0x000000,
    EnFClassColore    = 0Xf2f2f2,
};

#define IMAGECACHE_FOLDERNAME       @"imagecache"
#define IMAGECACHE_FOLDERNAME_CACHE @"bannerImagecache"
#define JSONFILE       @"JsonFile"
#endif /* PlanColorDef_h */
