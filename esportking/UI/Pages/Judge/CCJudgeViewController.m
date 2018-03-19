//
//  CCJudgeViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCJudgeViewController.h"
#import "CCUserView.h"
#import "CCCommitButton.h"

#import "CCFetchTagRequest.h"
#import "CCFetchUserInfoRequest.h"
#import "CCAddCommentRequest.h"

#define kTagBtnHeight   CCPXToPoint(56)
#define kCountBtnHeight CCPXToPoint(58)

@interface CCJudgeViewController ()<CCStarViewDelegate, CCRequestDelegate>

@property (assign, nonatomic) uint64_t userID;
@property (assign, nonatomic) GAMEID gameID;

@property (assign, nonatomic) uint32_t starCount;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *selectTagList;
@property (assign, nonatomic) uint32_t playCount;

@property (strong, nonatomic) CCFetchTagRequest *tagReq;
@property (strong, nonatomic) CCFetchUserInfoRequest *userReq;
@property (strong, nonatomic) CCAddCommentRequest *commentReq;

@property (strong, nonatomic) CCUserView *userView;
@property (strong, nonatomic) UILabel *judgeLabel;
@property (strong, nonatomic) NSArray<UIButton *> *tagBtnList;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) NSArray<UIButton *> *countBtnList;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) CCCommitButton *commitButton;

@end

@implementation CCJudgeViewController

- (instancetype)initWithUserID:(uint64_t)userID andGameID:(GAMEID)gameID
{
    if (self = [super init])
    {
        _userID = userID;
        _gameID = gameID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    
    self.userReq = [[CCFetchUserInfoRequest alloc] init];
    self.userReq.userID = self.userID;
    [self.userReq startPostRequestWithDelegate:self];
    
    self.tagReq = [CCFetchTagRequest new];
    self.tagReq.gameID = self.gameID;
    [self.tagReq startPostRequestWithDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.textView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"评价"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.judgeLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.commitButton];
    
    UIView *tagView = [UIView new];
    UIView *playCountView = [UIView new];
    [self.contentView addSubview:tagView];
    [self.contentView addSubview:playCountView];
    for (UIButton *button in self.tagBtnList)
    {
        [tagView addSubview:button];
    }
    for (UIButton *button in self.countBtnList)
    {
        [playCountView addSubview:button];
    }
    
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(UserViewWithoutBusiHeight);
    }];
    [self.judgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.userView.mas_bottom).offset(CCPXToPoint(32));
    }];
    
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.judgeLabel.mas_bottom).offset(48);
        make.centerX.equalTo(self.contentView);
    }];
    [self.tagBtnList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(tagView);
        make.width.mas_equalTo(CCPXToPoint(154));
        make.height.mas_equalTo(CCPXToPoint(56));
    }];
    [self.tagBtnList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagBtnList[0].mas_right).offset(CCPXToPoint(16));
        make.top.equalTo(self.tagBtnList[0]);
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagBtnList[1].mas_right).offset(CCPXToPoint(16));
        make.top.equalTo(self.tagBtnList[0]);
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tagView);
        make.left.equalTo(self.tagBtnList[2].mas_right).offset(CCPXToPoint(16));
        make.top.equalTo(self.tagBtnList[0]);
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagBtnList[0].mas_bottom).offset(CCPXToPoint(24));
        make.left.bottom.equalTo(tagView);
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[5] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagBtnList[4]);
        make.left.equalTo(self.tagBtnList[4].mas_right).offset(CCPXToPoint(16));
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[6] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagBtnList[4]);
        make.left.equalTo(self.tagBtnList[5].mas_right).offset(CCPXToPoint(16));
        make.size.equalTo(self.tagBtnList[0]);
    }];
    [self.tagBtnList[7] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tagView);
        make.top.equalTo(self.tagBtnList[4]);
        make.left.equalTo(self.tagBtnList[6].mas_right).offset(CCPXToPoint(16));
        make.size.equalTo(self.tagBtnList[0]);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagView.mas_bottom).offset(CCPXToPoint(58));
        make.centerX.equalTo(self.contentView);
    }];
    
    [playCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(CCPXToPoint(30));
        make.centerX.equalTo(self.contentView);
    }];
    [self.countBtnList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(playCountView);
        make.width.mas_equalTo(CCPXToPoint(100));
        make.height.mas_equalTo(CCPXToPoint(58));
    }];
    [self.countBtnList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBtnList[0].mas_right).offset(CCPXToPoint(16));
        make.centerY.equalTo(self.countBtnList[0]);
        make.size.equalTo(self.countBtnList[0]);
    }];
    [self.countBtnList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBtnList[1].mas_right).offset(CCPXToPoint(16));
        make.centerY.equalTo(self.countBtnList[0]);
        make.size.equalTo(self.countBtnList[0]);
    }];
    [self.countBtnList[3] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.countBtnList[2].mas_right).offset(CCPXToPoint(16));
        make.centerY.equalTo(self.countBtnList[0]);
        make.size.equalTo(self.countBtnList[0]);
    }];
    [self.countBtnList[4] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(playCountView);
        make.left.equalTo(self.countBtnList[3].mas_right).offset(CCPXToPoint(16));
        make.centerY.equalTo(self.countBtnList[0]);
        make.size.equalTo(self.countBtnList[0]);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playCountView.mas_bottom).offset(CCPXToPoint(58));
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(CCPXToPoint(686));
        make.height.mas_equalTo(CCPXToPoint(160));
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
}

#pragma mark - action
- (void)onClickTagButton:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected)
    {
        [self.selectTagList addObject:@(button.tag)];
        [button setBackgroundColor:BgColor_White];
        [button.layer setBorderColor:BgColor_Gold.CGColor];
    }
    else
    {
        [self.selectTagList removeObject:@(button.tag)];
        [button setBackgroundColor:BgColor_SuperLightGray];
        [button.layer setBorderColor:BgColor_Clear.CGColor];
    }
    [self checkAndSetCommitButton];
}

- (void)onClickCountButton:(UIButton *)button
{
    for (UIButton *btn in self.countBtnList)
    {
        [btn setSelected:NO];
        [btn setBackgroundColor:BgColor_SuperLightGray];
        [btn.layer setBorderColor:BgColor_Clear.CGColor];
    }

    [button setSelected:YES];
    [button setBackgroundColor:BgColor_White];
    [button.layer setBorderColor:BgColor_Gold.CGColor];
    
    self.playCount = (uint32_t)button.tag;
    [self checkAndSetCommitButton];
}

- (void)onClickCommitButton:(UIButton *)button
{
    self.commentReq = [CCAddCommentRequest new];
    self.commentReq.userID = self.userID;
    self.commentReq.gameID = self.gameID;
    self.commentReq.startCount = self.starCount;
    self.commentReq.successCount = self.playCount;
    self.commentReq.tagList = self.selectTagList;
    self.commentReq.commentContent = self.textView.text;
//    self.commentReq.totalCount = self.;
    [self.commentReq startPostRequestWithDelegate:self];
    [self beginLoading];
}

#pragma mark - CCStarViewDelegate
- (void)didSelectStarCount:(uint32_t)starCount
{
    self.starCount = starCount;
    [self checkAndSetCommitButton];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender == self.userReq)
    {
        CCUserModel *model = self.userReq.userModel;
        [self.userView setUserInfo:model businessCount:0 starCount:0];
        self.userReq = nil;
    }
    else if (sender == self.tagReq)
    {
        NSArray<CCTagModel *> *tagList = self.tagReq.tagList;
        for (int i=0; i<self.tagBtnList.count; i++)
        {
            UIButton *button = self.tagBtnList[i];
            if (i<tagList.count)
            {
                CCTagModel *model = tagList[i];
                [button setHidden:NO];
                button.tag = model.tagID;
                [button setTitle:model.tagName forState:UIControlStateNormal];
                [button setTitle:model.tagName forState:UIControlStateSelected];
            }
            else
            {
                [button setHidden:YES];
            }
        }
        self.tagReq = nil;
    }
    else if (sender == self.commentReq)
    {
        self.commentReq = nil;
        [self endLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender == self.userReq)
    {
        self.userReq = nil;
    }
    else if (sender == self.tagReq)
    {
        self.tagReq = nil;
    }
    else if (sender == self.commentReq)
    {
        self.commentReq = nil;
    }
    [self showToast:msg];
    [self endLoading];
}

#pragma mark - UITextFieldTextDidChangeNotification
- (void)textDidChange:(NSNotification *)sender
{
    if (sender.object != self.textView)
    {
        return;
    }
    
    UITextRange *markedTextRange = [self.textView markedTextRange];
    // 获取高亮部分
    UITextPosition *position = [self.textView positionFromPosition:markedTextRange.start offset:0];
    // 有高亮选择的字，则直接返回，不做处理
    if (position)
    {
        return;
    }
    
    NSString* newText = self.textView.text;
    
    if([newText length] > 50)
    {
        NSRange rangeIndex = [newText rangeOfComposedCharacterSequenceAtIndex:50];
        if (rangeIndex.length == 1)
        {
            newText = [newText substringToIndex:50];
        }
        else
        {
            newText = [newText substringToIndex:rangeIndex.location];
        }
        [self.textView setText:newText];
    }
}

#pragma mark - private
- (void)checkAndSetCommitButton
{
    if (self.starCount > 0 && self.playCount > 0 && self.selectTagList.count > 0)
    {
        [self.commitButton setEnabled:YES];
    }
    else
    {
        [self.commitButton setEnabled:NO];
    }
}

#pragma mark - getter
- (CCUserView *)userView
{
    if (!_userView)
    {
        _userView = [CCUserView new];
        [_userView setEnableBusiness:NO];
        [_userView setEnableTouch:YES del:self];
    }
    return _userView;
}

- (UILabel *)judgeLabel
{
    if (!_judgeLabel)
    {
        _judgeLabel = [UILabel createOneLineLabelWithFont:Font_Small color:[UIColor colorWithARGBHex:0xffa9a9a9]];
        [_judgeLabel setText:@"请给予评价"];
    }
    return _judgeLabel;
}

- (NSArray<UIButton *> *)tagBtnList
{
    if (!_tagBtnList)
    {
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0; i<8; i++)
        {
            UIButton *button = [UIButton new];
            [button.titleLabel setFont:Font_Middle];
            [button setTitleColor:[UIColor colorWithARGBHex:0xff555555] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithARGBHex:0xff252525] forState:UIControlStateSelected];
            [button setBackgroundColor:BgColor_SuperLightGray];
            [button.layer setCornerRadius:kTagBtnHeight/2.f];
            [button.layer setBorderWidth:CCOnePoint];
            [button.layer setBorderColor:BgColor_Clear.CGColor];
            [button addTarget:self action:@selector(onClickTagButton:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        _tagBtnList = array;
    }
    return _tagBtnList;
}

- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [UILabel createOneLineLabelWithFont:Font_Big color:[UIColor colorWithARGBHex:0xff555555]];
        [_countLabel setText:@"请确认胜利局数"];
    }
    return _countLabel;
}

- (NSArray<UIButton *> *)countBtnList
{
    if (!_countBtnList)
    {
        NSMutableArray *array = [NSMutableArray new];
        for (int i=0; i<5; i++)
        {
            UIButton *button = [UIButton new];
            button.tag = i+1;
            [button.titleLabel setFont:Font_Middle];
            [button setTitle:[NSString stringWithFormat:@"%d局", i+1] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%d局", i+1] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor colorWithARGBHex:0xff555555] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithARGBHex:0xff252525] forState:UIControlStateSelected];
            [button setBackgroundColor:BgColor_SuperLightGray];
            [button.layer setCornerRadius:CCPXToPoint(6)];
            [button.layer setBorderWidth:CCOnePoint];
            [button.layer setBorderColor:BgColor_Clear.CGColor];
            [button addTarget:self action:@selector(onClickCountButton:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        _countBtnList = array;
    }
    return _countBtnList;
}

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [UITextView new];
        _textView.font = Font_Middle;
        _textView.textColor = FontColor_Black;
        [_textView.layer setBorderWidth:CCOnePoint];
        [_textView.layer setBorderColor:[UIColor colorWithARGBHex:0xffdfdfdf].CGColor];
        [_textView.layer setCornerRadius:CCPXToPoint(12)];
    }
    return _textView;
}

- (CCCommitButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [CCCommitButton new];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(onClickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setEnabled:NO];
    }
    return _commitButton;
}

- (NSMutableArray<NSNumber *> *)selectTagList
{
    if (!_selectTagList)
    {
        _selectTagList = [NSMutableArray new];
    }
    return _selectTagList;
}

@end
