//
//  CCStarView.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCStarView.h"

@interface CCStarView ()

@property (weak  , nonatomic) id<CCStarViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray<UIImageView *> *starImgViewList;

@end

@implementation CCStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame starGap:0];
}

- (instancetype)initWithFrame:(CGRect)frame starGap:(CGFloat)gap
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUIWithGap:gap];
    }
    return self;
}

- (void)setupUIWithGap:(CGFloat)gap
{
    for (UIImageView *imgView in self.starImgViewList)
    {
        [self addSubview:imgView];
    }
    
    [self.starImgViewList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    [self.starImgViewList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[0].mas_right).offset(gap);
        make.width.equalTo(self.starImgViewList[0]);
    }];
    [self.starImgViewList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[1].mas_right).offset(gap);
        make.width.equalTo(self.starImgViewList[0]);
    }];
    [self.starImgViewList[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[2].mas_right).offset(gap);
        make.width.equalTo(self.starImgViewList[0]);
    }];
    [self.starImgViewList[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.starImgViewList[3].mas_right).offset(gap);
        make.right.equalTo(self);
        make.width.equalTo(self.starImgViewList[0]);
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

- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del
{
    _delegate = del;
    
    for (UIImageView *imgView in self.starImgViewList)
    {
        [imgView setUserInteractionEnabled:enable];
    }
}

#pragma mark - touch
- (void)onTapStar:(UITapGestureRecognizer *)gesture
{
    UIImageView *view = (UIImageView *)gesture.view;
    NSUInteger index = [self.starImgViewList indexOfObject:view];
    
    if (index!=NSNotFound)
    {
        [self setEvaluateStarCount:(uint32_t)index+1];
        [self.delegate didSelectStarCount:(uint32_t)index+1];
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
            UIImageView *starImgView = [UIImageView scaleFillImageView];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapStar:)];
            [starImgView addGestureRecognizer:gesture];
            [_starImgViewList addObject:starImgView];
        }
    }
    return _starImgViewList;
}

@end
