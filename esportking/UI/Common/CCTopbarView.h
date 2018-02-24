//
//  CCTopbarView.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTopbarView : UIView

// 左中右控件
@property(readonly) NSArray* leftControls;     // defualt - nil
@property(readonly) NSArray* rightControls;    // defualt - nil
@property(readonly) NSArray* midControls;      // defualt - nil

-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing;
-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset;
-(void)layoutLeftControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset leading:(CGFloat)leading;

-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing;
-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset;
-(void)layoutRightControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset trailing:(CGFloat)trailing;

-(void)layoutMidControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing;
-(void)layoutMidControls:(NSArray<UIView*>*)controls spacing:(NSArray*)spacing yOffset:(CGFloat)yOffset;

@end
