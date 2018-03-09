//
//  CCBaseTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseTableViewCell.h"

@implementation CCBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(CCOnePoint);
        }];
    }
    return self;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [_lineView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _lineView;
}

@end
