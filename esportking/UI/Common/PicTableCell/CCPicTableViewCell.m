//
//  CCPicTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPicTableViewCell.h"

@interface CCPicTableViewCell()

@end

@implementation CCPicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        _imgView = [UIImageView scaleFillImageView];
    }
    return _imgView;
}

@end
