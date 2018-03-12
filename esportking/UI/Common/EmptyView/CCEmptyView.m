//
//  CCEmptyView.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCEmptyView.h"

@interface CCEmptyView ()

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation CCEmptyView

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.imgView];
    [self addSubview:self.descLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-CCPXToPoint(50));
        make.width.height.mas_equalTo(CCPXToPoint(160));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imgView.mas_bottom).offset(CCPXToPoint(40));
    }];
}

#pragma mark - getter
- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [UIImageView scaleFillImageView];
        [_imgView setImage:CCIMG(@"Placeholder_Icon")];
    }
    return _imgView;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_descLabel setText:@"暂无结果"];
    }
    return _descLabel;
}

@end
