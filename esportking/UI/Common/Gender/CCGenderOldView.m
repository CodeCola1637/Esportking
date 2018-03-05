//
//  CCGenderOldView.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGenderOldView.h"

@interface CCGenderOldView ()

@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UIImageView *genderImgView;
@property (strong, nonatomic) UILabel *oldLabel;

@end

@implementation CCGenderOldView

- (instancetype)init
{
    if (self = [super init])
    {
        [self addSubview:self.centerView];
        [self.centerView addSubview:self.genderImgView];
        [self.centerView addSubview:self.oldLabel];
        
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.equalTo(self).offset(CCPXToPoint(10));
            make.right.equalTo(self).offset(-CCPXToPoint(10));
        }];
        [self.genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerView);
            make.centerY.equalTo(self.centerView);
        }];
        [self.oldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.genderImgView.mas_right).offset(CCPXToPoint(4));
            make.right.equalTo(self.centerView);
            make.centerY.equalTo(self.centerView);
        }];
    }
    return self;
}

- (void)setGender:(GENDER)gender andOld:(uint64_t)old
{
    if (gender == GENDER_BOY)
    {
        [self.genderImgView setImage:CCIMG(@"Gender_Boy")];
        [self setBackgroundColor:BgColor_Blue];
    }
    else if (gender == GENDER_GIRL)
    {
        [self.genderImgView setImage:CCIMG(@"Gender_Girl")];
        [self setBackgroundColor:BgColor_Pink];
    }
    [self.oldLabel setText:[NSString stringWithFormat:@"%llu", old]];
}

#pragma mark - getter
- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [UIView new];
    }
    return _centerView;
}

- (UIImageView *)genderImgView
{
    if (!_genderImgView)
    {
        _genderImgView = [UIImageView scaleFillImageView];
    }
    return _genderImgView;
}

- (UILabel *)oldLabel
{
    if (!_oldLabel)
    {
        _oldLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_White];
    }
    return _oldLabel;
}

@end
