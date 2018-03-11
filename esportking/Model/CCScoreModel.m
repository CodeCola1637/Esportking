//
//  CCScoreModel.m
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreModel.h"
#import "CCCalculateRequest.h"

@interface CCScoreModel()<CCRequestDelegate>

@property (strong, nonatomic) void(^calBlock)(BOOL, uint32_t);
@property (strong, nonatomic) CCCalculateRequest *request;
@property (assign, nonatomic) uint32_t money;

@end

@implementation CCScoreModel

- (instancetype)init
{
    if (self = [super init])
    {
        _money = 0;
        _needReCaculate = YES;
    }
    return self;
}

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

- (void)calCulateMoney:(void(^)(BOOL, uint32_t))calculateBlock;
{
    if ([self checkInfoCompleted])
    {
        if (_needReCaculate)
        {
            _calBlock = calculateBlock;
            _request = [CCCalculateRequest new];
            if (_style == SCORESTYLE_SCORE)
            {
                _request.fromDan = self.startLevel/100;
                _request.fromDetailLevel = self.startLevel%100;
                _request.fromDetailStar = self.startLevel%100;
                
                _request.toDan = self.endLevel/100;
                _request.toDetailLevel = self.endLevel%100;
                _request.toDetailStar = self.endLevel%100;
            }
            else
            {
                _request.fromDan = self.level;
                _request.count = self.count;
            }
            [_request startPostRequestWithDelegate:self];
        }
        else
        {
            calculateBlock(YES, _money);
        }
    }
    else
    {
        calculateBlock(NO, 0);
    }
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    _request = nil;
    
    _needReCaculate = NO;
    _money = (uint32_t)[dict[@"data"] unsignedIntegerValue];
    if (_calBlock)
    {
        _calBlock(YES, _money);
        _calBlock = nil;
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    _request = nil;
    
    _needReCaculate = YES;
    _money = 0;
    if (_calBlock)
    {
        _calBlock(YES, _money);
        _calBlock = nil;
    }
}

#pragma mark - setters
- (void)setStyle:(SCORESTYLE)style
{
    if (_style != style)
    {
        _style = style;
        _needReCaculate = YES;
    }
}

- (void)setStartLevel:(uint32_t)startLevel
{
    if (_startLevel != startLevel)
    {
        _startLevel = startLevel;
        _needReCaculate = YES;
    }
}

- (void)setEndLevel:(uint32_t)endLevel
{
    if (_endLevel != endLevel)
    {
        _endLevel = endLevel;
        _needReCaculate = YES;
    }
}

- (void)setLevel:(LEVEL)level
{
    if (_level != level)
    {
        _level = level;
        _needReCaculate = YES;
    }
}

- (void)setCount:(uint32_t)count
{
    if (_count != count)
    {
        _count = count;
        _needReCaculate = YES;
    }
}

#pragma mark - util
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
