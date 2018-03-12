//
//  CCHeadTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHeadTableViewCell.h"

@interface CCHeadTableViewCell ()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nickLabel;

@end

@implementation CCHeadTableViewCell

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
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nickLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(80));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(100), CCPXToPoint(100)));
    }];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(24));
        make.centerX.equalTo(self.contentView);
    }];
}

#pragma mark - getters
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
        [_headImgView.layer setCornerRadius:CCPXToPoint(50)];
        [_headImgView setImageWithUrl:CCAccountServiceInstance.headUrl placeholder:CCIMG(@"Default_Header")];
    }
    return _headImgView;
}

- (UILabel *)nickLabel
{
    if (!_nickLabel)
    {
        _nickLabel = [UILabel createOneLineLabelWithFont:BoldFont_Big color:FontColor_Black];
        [_nickLabel setText:CCAccountServiceInstance.name];
    }
    return _nickLabel;
}

@end
