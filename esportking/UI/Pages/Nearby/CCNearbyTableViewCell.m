//
//  CCNearbyTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCNearbyTableViewCell.h"
#import "CCGenderOldView.h"

@interface CCNearbyTableViewCell ()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) CCGenderOldView *genderView;

@end

@implementation CCNearbyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}

- (void)setGameModel:(CCGameModel *)model
{
    
}

@end
