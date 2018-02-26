//
//  CCUserTagTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserTagTableViewCell.h"
#import "CCTagView.h"

@interface CCUserTagTableViewCell ()

@property (strong, nonatomic) NSArray<CCTagModel *> *tagModelList;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray<CCTagView *> *tagViewList;

@end

@implementation CCUserTagTableViewCell

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
    
    [self.contentView addSubview:self.titleLabel];
    for (int i=0; i<self.tagViewList.count; i++)
    {
        [self.tagViewList[i] setHidden:YES];
        [self.contentView addSubview:self.tagViewList[i]];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(CCPXToPoint(32));
    }];
    [self.tagViewList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(36));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CCPXToPoint(38));
    }];
    [self.tagViewList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.tagViewList[0]);
    }];
    [self.tagViewList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(36));
        make.centerY.equalTo(self.tagViewList[0]);
    }];
    [self.tagViewList[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tagViewList[0]);
        make.top.equalTo(self.tagViewList[0].mas_bottom).offset(CCPXToPoint(16));
    }];
    [self.tagViewList[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tagViewList[1]);
        make.top.equalTo(self.tagViewList[1].mas_bottom).offset(CCPXToPoint(16));
    }];
    [self.tagViewList[5] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tagViewList[2]);
        make.top.equalTo(self.tagViewList[2].mas_bottom).offset(CCPXToPoint(16));
    }];
}

- (void)setTagList:(NSArray<CCTagModel *> *)tagList
{
    self.tagModelList = tagList;
    for (int i = 0; i<tagList.count && i<6; i++)
    {
        CCTagModel *model = tagList[i];
        CCTagView *tagView = self.tagViewList[i];
        [tagView setTagModel:model withColor:nil];
        [tagView setHidden:NO];
    }
    for (NSUInteger i=tagList.count; i<self.tagViewList.count; i++)
    {
        [self.tagViewList[i] setHidden:YES];
    }
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_titleLabel setText:@"用户评价"];
    }
    return _titleLabel;
}

- (NSMutableArray<CCTagView *> *)tagViewList
{
    if (!_tagViewList)
    {
        _tagViewList = [NSMutableArray new];
        for (int i=0; i<6; i++)
        {
            [_tagViewList addObject:[CCTagView new]];
        }
    }
    return _tagViewList;
}

@end
