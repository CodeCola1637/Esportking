//
//  CCStarView.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCStarView.h"

@interface CCStarView ()

@property (strong, nonatomic) NSMutableArray<UIImageView *> *starImgViewList;

@end

@implementation CCStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    for (UIImageView *imgView in self.starImgViewList)
    {
        [self addSubview:imgView];
    }
    
    CGFloat gap = 0;
    
    [self.starImgViewList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
    }];
    [self.starImgViewList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[0].mas_right).offset(gap);
    }];
    [self.starImgViewList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[1].mas_right).offset(gap);
    }];
    [self.starImgViewList[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[2].mas_right).offset(gap);
    }];
    [self.starImgViewList[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[3].mas_right).offset(gap);
        make.right.equalTo(self);
    }];
}

- (void)setEvaluateStarCount:(uint32_t)starCount
{
    for (int i=0; i<self.starImgViewList.count; i++)
    {
        UIImageView *starImgView = self.starImgViewList[i];
        if (i<starCount)
        {
            [starImgView setImage:CCIMG(@"Star")];
        }
        else
        {
            [starImgView setImage:CCIMG(@"UnStar")];
        }
    }
}

#pragma mark - getter
- (NSMutableArray<UIImageView *> *)starImgViewList
{
    if (!_starImgViewList)
    {
        _starImgViewList = [NSMutableArray new];
        for (int i=0; i<5; i++)
        {
            UIImageView *starImgView = [UIImageView new];
            [starImgView setContentMode:UIViewContentModeScaleAspectFill];
            [_starImgViewList addObject:starImgView];
        }
    }
    return _starImgViewList;
}

@end
