//
//  CCUIStandard.h
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

//
//  LMUIStandard.h
//  LiveMaster
//
//  Created by 王泽平 on 17/5/2016.
//  Copyright © 2016 Tencent. All rights reserved.
//  定义UI规范

#import "UIColor+Hex.h"

// 屏幕尺寸
#define LM_SCREEN_WIDTH     ([UIScreen mainScreen].bounds.size.width)
#define LM_SCREEN_HEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define LM_IS_LANDSCAPE     (LM_SCREEN_WIDTH > LM_SCREEN_HEIGHT)

#define LM_ABSOLUTE_SCREEN_WIDTH    (LM_IS_LANDSCAPE ? LM_SCREEN_HEIGHT : LM_SCREEN_WIDTH)
#define LM_ABSOLUTE_SCREEN_HEIGHT   (LM_IS_LANDSCAPE ? LM_SCREEN_WIDTH : LM_SCREEN_HEIGHT)

#define LM_FULLSCREEN               CGRectMake(0, 0, LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)
#define LM_MIN_SCREEN_WIDTH         MIN(LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)
#define LM_MAX_SCREEN_WIDTH         MAX(LM_SCREEN_WIDTH, LM_SCREEN_HEIGHT)

#define LMDimensionHeight_iPhone4 (480)
#define LMDimensionHeight_iPhone5 (568)
#define LMDimensionHeight_iPhone6 (667)
#define LMDimensionHeight_iPhone6Plus (960)

// SafeArea
#define LM_IS_iPhoneX ((CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375.0f, 812.0f)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812.0f, 375.0f)))? YES:NO)

#define LMSafeAreaTopHeight (LM_IS_LANDSCAPE? 0.:44.)
#define LMSafeAreaBottomHeight (LM_IS_LANDSCAPE? 21.:34.)
#define LMSafeAreaHorizontalWidth 44.

#define LMLayoutAreaTopHeight (LM_IS_iPhoneX? LMSafeAreaTopHeight:0)
#define LMLayoutAreaBottomHeight (LM_IS_iPhoneX? LMSafeAreaBottomHeight:0)
#define LMLayoutAreaHorizontalWidth (LM_IS_iPhoneX? LMSafeAreaHorizontalWidth:0)

// 栅格定义
#define CCOnePoint  1.f
#define CCPXToPoint(n) ceilf((n)/2.f*LM_SCREEN_WIDTH/375.f)

// 通用左右间距
#define CCHorMargin CCPXToPoint(32)

// 图片间分割线的高度
#define LMPicLineHeight  (LMSizeUnitna(3))
#define LMPicLineWidth  LMPicLineHeight

/*********************************/
#pragma mark -- Navi And Bottom
/*********************************/

// 底部
#define LMBottomBarContentHeight LMSizeUnitna(18)
#define LMBottomBarRealHeight (LM_IS_iPhoneX? (LMBottomBarContentHeight+LMSafeAreaBottomHeight):LMBottomBarContentHeight)
#define LMBottomAppearanceHeight (LM_IS_iPhoneX? (LMSizeUnitna(15)+LMSafeAreaBottomHeight):LMSizeUnitna(15))

// 头部
#define LMStatusBarHeight (LM_IS_iPhoneX? LMSafeAreaTopHeight:20.)
#define LMTopBarHeight 44.

// 偏移超过这个值显示上下控件，否则隐藏
#define LMShowControlOffset (LMBottomBarRealHeight / 2.)


/*********************************/
#pragma mark -- Colors
/*********************************/

////文字颜色规范
#define FontColor_Purple ([UIColor colorWithARGBHex:0xff6956ff])
#define FontColor_Yellow ([UIColor colorWithARGBHex:0xffffc600])
#define FontColor_Gold   ([UIColor colorWithARGBHex:0xffffe353])
#define FontColor_LightBlue ([UIColor colorWithARGBHex:0xff56ffed])
#define FontColor_Red ([UIColor colorWithARGBHex:0xffff0000])
#define FontColor_Beige ([UIColor colorWithARGBHex:0xfffdf7ae])
#define FontColor_DeepGray ([UIColor colorWithARGBHex:0xffa9a9a9])
#define FontColor_Gray ([UIColor colorWithARGBHex:0xffc7c7c7])
#define FontColor_LightGray ([UIColor colorWithARGBHex:0xffc2c2c2])
#define FontColor_SuperLightGray ([UIColor colorWithARGBHex:0xfff2f2f2])
#define FontColor_DeepDark ([UIColor colorWithARGBHex:0xff848484])
#define FontColor_White ([UIColor whiteColor])

#define FontColor_Black ([UIColor blackColor])
#define FontColor_Dark ([[UIColor blackColor] colorWithAlphaComponent:.7f])
#define FontColor_LightDark ([[UIColor blackColor] colorWithAlphaComponent:.5f])
#define FontColor_SuperLightDark ([[UIColor blackColor] colorWithAlphaComponent:.3f])

////背景前景颜色,请将背景、前景与文字颜色分开定义
#define BgColor_Clear  [UIColor clearColor]
#define BgColor_Purple ([UIColor colorWithARGBHex:0xff6956ff])
#define BgColor_Yellow ([UIColor colorWithARGBHex:0xffffc600])
#define BgColor_Gold   ([UIColor colorWithARGBHex:0xffffe353])
#define BgColor_Blue   ([UIColor colorWithARGBHex:0xff84c1ff])

#define BgColor_Orange ([UIColor colorWithARGBHex:0xffffac00])
#define BgColor_Green  ([UIColor colorWithARGBHex:0xff12b68f])
#define BgColor_Pink   ([UIColor colorWithARGBHex:0xffff90a8])
#define BgColor_Gray   ([UIColor colorWithARGBHex:0xffc7c7c7])
#define BgColor_LightGray ([UIColor colorWithARGBHex:0xffc2c2c2])
#define BgColor_SuperLightGray ([UIColor colorWithARGBHex:0xfff2f2f2])
#define BgColor_DeepDark ([UIColor colorWithARGBHex:0xff848484])
#define BgColor_DeepGray ([UIColor colorWithARGBHex:0xffa9a9a9])

#define BgColor_White [UIColor whiteColor]

#define BgColor_Black ([UIColor blackColor])

#define BgColor_Dark ([[UIColor blackColor] colorWithAlphaComponent:.7f])
#define BgColor_LightDark ([[UIColor blackColor] colorWithAlphaComponent:.5f])
#define BgColor_SuperLightDark ([[UIColor blackColor] colorWithAlphaComponent:.3f])

//// 房间专用黑色
#define BgColor_RoomDark ([[UIColor blackColor] colorWithAlphaComponent:.4f])

////分割线和描边颜色
#define DevideLineColor_LightWhite ([[UIColor whiteColor] colorWithAlphaComponent:.05f])

//#define BoarderColor_
#define BorderColor_White ([UIColor whiteColor])
#define BorderColor_Gray ([UIColor colorWithARGBHex:0xff999999])
#define BorderColor_DeepGray ([UIColor colorWithARGBHex:0xff666666])

////Bar和背景颜色
#define LMTopBarColor [UIColor colorWithARGBHex:0xff160937]
#define LMBottomBarColor [UIColor colorWithARGBHex:0xda000000]
#define LMDefautBGColor [UIColor colorWithARGBHex:0xff160937]

////Debug颜色
#define DebugColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:.2]

////未分类颜色
#define LMCellHighLightColor ([[UIColor whiteColor] colorWithAlphaComponent:.03f])

/*********************************/
#pragma mark -- Font And Size
/*********************************/


//这里暂时用的系统字体，稍后由ak修改
#define AppNormalBoldFontWithSize(size)    [UIFont boldSystemFontOfSize:(size)]
#define AppNormalFontWithSize(size)    [UIFont systemFontOfSize:(size)]

// 字号
#define FontSizeGreat (21)
#define FontSizeLarge (18)
#define FontSizeBig (16)
#define FontSizeMiddle (14)
#define FontSizeSmall (12)
#define FontSizeTiny (10)

// 字号 - 简易接口
// 普通体
#define Font_Great AppNormalFontWithSize(FontSizeGreat)
#define Font_Large AppNormalFontWithSize(FontSizeLarge)
#define Font_Big AppNormalFontWithSize(FontSizeBig)
#define Font_Middle AppNormalFontWithSize(FontSizeMiddle)
#define Font_Small AppNormalFontWithSize(FontSizeSmall)
#define Font_Tiny AppNormalFontWithSize(FontSizeTiny)

// 粗体
#define BoldFont_Great AppNormalBoldFontWithSize(FontSizeGreat)
#define BoldFont_Large AppNormalBoldFontWithSize(FontSizeLarge)
#define BoldFont_Big AppNormalBoldFontWithSize(FontSizeBig)
#define BoldFont_Middle AppNormalBoldFontWithSize(FontSizeMiddle)
#define BoldFont_Small AppNormalBoldFontWithSize(FontSizeSmall)
#define BoldFont_Tiny AppNormalBoldFontWithSize(FontSizeTiny)

/*********************************/
#pragma mark -- Line && Radius
/*********************************/

// 边框描边宽度
#define AppRectBoarderSizeThin (1)
#define AppRectBoarderSizeBold (2)

//分割线高度
#define AppCutlineHeightThin (0.5)
#define AppCutlineHeightBold (1.0)

// 图片圆角的弧度
#define AppRectEdgeRadiusSize (LMSizeUnit1a)

/*********************************/
#pragma mark -- Animation
/*********************************/

#define LMAnimateWithDuration (0.25)

#define CCIMG(str) [UIImage imageNamed:str]
#define CCBannerItemSize CGSizeMake(CCPXToPoint(540), CCPXToPoint(540))
