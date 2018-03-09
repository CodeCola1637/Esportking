//
//  CCScoreBannerTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreBannerTableViewCell.h"
#import "CCUserView.h"

@interface CCScoreBannerTableViewCell ()

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) CCUserView *userView;

@end

@implementation CCScoreBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setEvaluateUserModel:(CCEvaluateUserModel *)model
{
    
}

#pragma mark - getter
- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [UIImageView scaleFillImageView];
        [_imgView setImage:CCIMG(@"Score_Banner")];
    }
    return _imgView;
}

- (CCUserView *)userView
{
    if (!_userView)
    {
        _userView = [CCUserView new];
    }
    return _userView;
}

@end
