//
//  CCUserCommentTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserCommentTableViewCell.h"
#import "CCStarView.h"

@interface CCUserCommentTableViewCell ()

@property (strong, nonatomic) CCCommentModel *comment;

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *rateLabel;
@property (strong, nonatomic) UILabel *envaluateLabel;
@property (strong, nonatomic) CCStarView *starView;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UIView *bottomLineView;

@end

@implementation CCUserCommentTableViewCell

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
    [self setBackgroundColor:BgColor_White];
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.rateLabel];
    [self.contentView addSubview:self.envaluateLabel];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.bottomLineView];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(36));
        make.top.equalTo(self.contentView).offset(CCPXToPoint(30));
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(76), CCPXToPoint(76)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(CCPXToPoint(28));
        make.top.equalTo(self.contentView).offset(CCPXToPoint(36));
        make.right.lessThanOrEqualTo(self.rateLabel.mas_left);
    }];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(36));
        make.top.equalTo(self.contentView).offset(CCPXToPoint(36));
    }];
    [self.envaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.envaluateLabel.mas_right).offset(CCPXToPoint(4));
        make.centerY.equalTo(self.envaluateLabel);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.lessThanOrEqualTo(self.contentView).offset(-CCPXToPoint(36));
        make.top.equalTo(self.envaluateLabel.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCOnePoint);
    }];
}

+ (CGFloat)heightWithComment:(CCCommentModel *)comment
{
    CGFloat height = CCPXToPoint(36)+Font_Middle.lineHeight+CCPXToPoint(12)+Font_Middle.lineHeight+CCPXToPoint(12)+CCPXToPoint(20);
    height += [comment.comment boundingRectWithSize:CGSizeMake(LM_SCREEN_WIDTH-CCPXToPoint(72), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font_Middle} context:nil].size.height;
    return ceilf(height);
}

- (void)setCommentModel:(CCCommentModel *)model
{
    self.comment = model;
    
    [self.headImgView setImageWithUrl:model.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.nameLabel setText:model.userName];
    [self.rateLabel setText:[NSString stringWithFormat:@"胜率%d%%(%llu/%llu)", (int)(100.f*model.successCount/model.totalCount), model.successCount, model.totalCount]];
    [self.starView setEvaluateStarCount:(uint32_t)model.star];
    [self.commentLabel setText:model.comment];
}

#pragma mark - getter
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView new];
        [_headImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_headImgView setClipsToBounds:YES];
        [_headImgView.layer setCornerRadius:CCPXToPoint(38)];
    }
    return _headImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _nameLabel;
}

- (UILabel *)rateLabel
{
    if (!_rateLabel)
    {
        _rateLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _rateLabel;
}

- (UILabel *)envaluateLabel
{
    if (!_envaluateLabel)
    {
        _envaluateLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_envaluateLabel setText:@"评分："];
    }
    return _envaluateLabel;
}

- (CCStarView *)starView
{
    if (!_starView)
    {
        _starView = [CCStarView new];
    }
    return _starView;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel)
    {
        _commentLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_commentLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _commentLabel;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [UIView new];
        [_bottomLineView setBackgroundColor:BgColor_Gray];
    }
    return _bottomLineView;
}

@end
