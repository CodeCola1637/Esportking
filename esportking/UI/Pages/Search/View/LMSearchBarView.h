//
//  LMSearchBarView.h
//  LiveMaster
//
//  Created by Guangcheng Sun on 5/26/16.
//  Copyright © 2016 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMSearchBarDelegate <NSObject>

-(void)onCancelSearch;
-(void)onSearch:(NSString*)keywords;

@end

@interface LMSearchBarView : UIView

@property (nonatomic, assign) NSUInteger maxTextLength; // 默认无限制
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, weak) id<LMSearchBarDelegate> delegate;

- (instancetype)initWithLeftView:(UIView *)leftView;
- (void)setContainerColor:(UIColor *)color;  // 默认10%白色
- (void)setCancelButtonHidden:(BOOL)hidden animaiton:(BOOL)animated;

@end
