//
//  CCAddImageView.h
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ADDIMGSTATUS_EMPTY,
    ADDIMGSTATUS_NORMAL,
    ADDIMGSTATUS_DELETE,
} ADDIMGSTATUS;

@protocol CCAddImageViewDelegate<NSObject>

- (void)onClickAddImgViewWithStatus:(ADDIMGSTATUS)status sender:(id)sender;

@end

@interface CCAddImageView : UIView

@property (weak  , nonatomic) id<CCAddImageViewDelegate> delegate;
@property (assign, nonatomic) ADDIMGSTATUS currentStatus;
@property (strong, nonatomic) NSString *coverUrl;

- (void)setImage:(UIImage *)img;
- (void)setImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder;

@end
