//
//  IMColor.h
//  planGodDelgate
//
//  Created by ZeroSmell on 16/11/2.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 自定义枚举
 */
typedef NS_ENUM(NSInteger, IMColor) {
    IMColorModeNever = 1,
    IMColorModeWhileEditing,
    IMColorModeUnlessEditing,
    IMColorModeAlways
};

/*
 *自定义RGB颜色值枚举
 */
typedef NS_ENUM(UInt32, ColorRGBType) {
    DefaulColor       = 0xf2a0d5,
    SearchTypeColor   = 0x999999,
    EbebebColor       = 0xebebeb,
    LineColore        = 0xd6d6d6,
    BgGrayColore      = 0x000000,
    EnFClassColore    = 0Xf2f2f2,
};

/*
 * 自定义NS_ENUN枚举 NSUInteger无符号的无负数,NSInteger是有符号的
 */
typedef enum EOCConnectionSate : NSUInteger EOCConnectionSate;
enum EOCConnectionSate : NSUInteger {
     EOCConnectionDisNever = 1,
     EOCConnectionContEditing,
     EOCConnectionContAlways,
};

/*
 * typedef关键字定义的枚举类型
 */
enum DFCConnectionState : NSUInteger {
    DFCConnectionNormal = 1,
    DFCConnectionContHighlighted,
    DFCConnectionContDisabled,
    DFCConnectionContSelected,
    DFCConnectionContFocused,
    DFCConnectionContApplication,
    DFCConnectionContReserved,
};
typedef enum DFCConnectionState DFCConnectionState;

/*
 *定义switch类型枚举
 */
typedef NS_ENUM(NSInteger,ENUMActionType){
    ENUMActionTypeStart=0,//开始
    ENUMActionTypeStop,//停止
    ENUMActionTypePause//暂停
};

/*
 * 一般用来定义具有位移操作或特点的情况枚举类型
 */
typedef NS_OPTIONS(NSUInteger, EOCPerminttedDirection) {
    EOCPerminttedDirectionUp     = 1<<0,
    EOCPerminttedDirectionDown   = 1<<1,
    EOCPerminttedDirectionLeft   = 1<<2,
    EOCPerminttedDirectionRigth  = 1<<3,
};

@interface  UIColor(IMColor)
@end

@interface DFCPerson : NSObject

@property(nonatomic,readonly,copy) NSString *firstName;
@property(nonatomic,readonly,copy) NSString *lastName;

-(NSString*)firstName;
-(void)setFirstName:(NSString *)firstName;
-(NSString*)lastName;
-(void)setLastName:(NSString *)lastName;

@end


