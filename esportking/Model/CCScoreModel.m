//
//  CCScoreModel.m
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreModel.h"

@implementation CCScoreModel

- (BOOL)checkInfoCompleted
{
    if (self.style == 0)
    {
        return NO;
    }
    if (self.system == 0)
    {
        return NO;
    }
    if (self.platform == 0)
    {
        return NO;
    }
    if (_style == SCORESTYLE_GAME)
    {
        if (self.level == 0)
        {
            return NO;
        }
        if (self.count == 0)
        {
            return NO;
        }
    }
    else
    {
        if (self.startLevel == 0)
        {
            return NO;
        }
        if (self.endLevel == 0)
        {
            return NO;
        }
    }
    return YES;
}

- (uint32_t)calCulateMoney
{
    if ([self checkInfoCompleted])
    {
        return 100;
    }
    return 0;
}

+ (NSString *)getSytleStr:(SCORESTYLE)style
{
    NSString *str = nil;
    switch (style)
    {
        case SCORESTYLE_SCORE:
        {
            str = @"上分专车";
        }
            break;
        case SCORESTYLE_GAME:
        {
            str = @"娱乐专车";
        }
            break;
            
        default:
            break;
    }
    return str;
}

+ (NSString *)getSystemStr:(SYSTEM)system
{
    NSString *str = nil;
    switch (system)
    {
        case SYSTEM_iOS:
        {
            str = @"苹果平台";
        }
            break;
        case SYSTEM_Android:
        {
            str = @"安卓平台";
        }
            break;
            
        default:
            break;
    }
    return str;
}

+ (NSString *)getPlatformStr:(PLATFORM)platform
{
    NSString *str = nil;
    switch (platform)
    {
        case PLATFORM_QQ:
        {
            str = Wording_Platform_QQ;
        }
            break;
        case SYSTEM_Android:
        {
            str = Wording_Platform_WX;
        }
            break;
            
        default:
            break;
    }
    return str;
}

+ (NSString *)getDetailLevelStr:(uint32_t)level
{
    if (level >= 101)
    {
        return Wording_Dan_List_Detail[(int)level/100-1][level%100-1];
    }
    return nil;
}

+ (NSString *)getLevelStr:(uint32_t)level
{
    if (level > 0 && level < LEVEL_WANGZHE)
    {
        return Wording_Dan_List[level-1];
    }
    return nil;
}

+ (NSString *)getCountStr:(uint32_t)count
{
    return [NSString stringWithFormat:@"%d局", count];
}

@end
