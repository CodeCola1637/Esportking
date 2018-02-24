//
//  CCTopbarView.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTopbarView.h"

#define LMTopControlViewDefaultLeftBtnMargin CCHorMargin
#define LMTopControlViewDefaultRightBtnMargin CCHorMargin

@implementation CCTopbarView
{
    UIView* _midControlsContainer;
}

-(id)init
{
    CGRect frame = {0, 0, LM_SCREEN_WIDTH, LMTopBarHeight + LMStatusBarHeight};
    return [self initWithFrame:frame];
}

-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing
{
    [self layoutLeftControls:controls spacing:spacing yOffset:LMStatusBarHeight/ 2.];
}

-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset
{
    [self layoutLeftControls:controls spacing:spacing yOffset:yOffset leading:LMTopControlViewDefaultLeftBtnMargin];
}

-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset leading:(CGFloat)leading
{
    NSAssert([spacing count] == [controls count] - 1, @"当控件的时候，间距个数=控件个数-1");
    [self removeLeftControls];
    
    if(![controls count])
        return;
    
    _leftControls = controls;
    
    // add subViews
    for (UIView* control in controls)
    {
        [self addSubview:control];
    }
    
    // layout
    for(int i = 0; i < [controls count]; ++i)
    {
        UIView* control = controls[i];
        [control mas_makeConstraints:^(MASConstraintMaker *make)
         {
             if(i > 0)
             {
                 UIView* preControl = controls[i - 1];
                 make.left.equalTo(preControl.mas_right).offset([spacing[i - 1] floatValue]);
             }
             else
             {
                 make.left.equalTo(self.mas_left).offset(leading);
             }
             make.centerY.equalTo(self.mas_centerY).offset(yOffset);
         }];
    }
}

-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing
{
    [self layoutRightControls:controls spacing:spacing yOffset:LMStatusBarHeight/ 2.];
}

-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset
{
    [self layoutRightControls:controls spacing:spacing yOffset:yOffset trailing:LMTopControlViewDefaultRightBtnMargin];
}

-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset trailing:(CGFloat)trailing
{
    NSAssert([spacing count] == [controls count] - 1, @"当控件的时候，间距个数=控件个数-1");
    [self removeRightControls];
    
    if(![controls count])
        return;
    
    _rightControls = controls;
    
    // add subViews
    for (UIView* control in controls)
    {
        [self addSubview:control];
    }
    
    // layout
    for(int i = 0; i < [controls count]; ++i)
    {
        UIView* control = controls[i];
        [control mas_makeConstraints:^(MASConstraintMaker *make)
         {
             if(i != [controls count] - 1)
             {
                 UIView* nextControl = controls[i + 1];
                 make.right.equalTo(nextControl.mas_left).offset(-[spacing[i] floatValue]);
             }
             else
             {
                 make.right.equalTo(self.mas_right).offset(-trailing);
             }
             make.centerY.equalTo(self.mas_centerY).offset(yOffset);
         }];
    }
}


-(void)layoutMidControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing
{
    [self layoutMidControls:controls spacing:spacing yOffset:LMStatusBarHeight/ 2.];
}

-(void)layoutMidControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset
{
    NSAssert([spacing count] == [controls count] - 1, @"当控件的时候，间距个数=控件个数-1");
    [self removeMidControls];
    
    if(![controls count])
        return;
    
    _midControlsContainer = [UIView new];
    [self addSubview:_midControlsContainer];
    _midControls = controls;
    
    // add subViews
    for(UIView* control in controls)
    {
        [_midControlsContainer addSubview:control];
    }
    
    
    // layout
    [_midControlsContainer mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(self.mas_centerX);
         make.top.bottom.equalTo(self);
     }];
    
    UIView* firstCtl = controls[0];
    [firstCtl mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(_midControlsContainer.mas_left);
         make.centerY.equalTo(_midControlsContainer.mas_centerY).offset(yOffset);
     }];
    
    
    UIView* lastCtl = controls[[controls count] - 1];
    [lastCtl mas_makeConstraints:^(MASConstraintMaker *make) { make.right.equalTo(_midControlsContainer.mas_right); }];
    
    for(int i = 1; i < [controls count]; ++i)
    {
        UIView* control = controls[i];
        [control mas_makeConstraints:^(MASConstraintMaker *make)
         {
             UIView* preControl = controls[i - 1];
             make.left.equalTo(preControl.mas_right).offset([spacing[i - 1] floatValue]);
             make.centerY.equalTo(_midControlsContainer.mas_centerY).offset(yOffset);
         }];
    }
}


-(void)removeLeftControls
{
    [_leftControls makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _leftControls = nil;
}

-(void)removeMidControls
{
    [_midControlsContainer removeFromSuperview];
    _midControlsContainer = nil;
}

-(void)removeRightControls
{
    [_rightControls makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _leftControls = nil;
}

@end
