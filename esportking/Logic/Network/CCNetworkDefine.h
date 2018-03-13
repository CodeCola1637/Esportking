//
//  CCNetworkDefine.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#define RootAddress     @"http://120.79.9.197:8080"

#pragma mark - Post
#define PhoneLogin      @"/app/login/login"
#define ThirdLogin      @"/app/login/openLogin"
#define GetSMSCode      @"/app/user/getSmsCode"
#define Register        @"/app/user/register"
#define ChangePwd       @"/app/user/changePassword"
#define ModifyUser      @"/app/user/updateInfo"

#define GetDetailInfo   @"/app/home/detail"
#define HomePage        @"/app/home"
#define Search          @"/app/home/search"
#define Nearby          @"/app/home/nearby"

#define GetOrder        @"/app/order/getOrder"
#define Calculate       @"/app/order/calculator"
#define PublishOrder    @"/app/order/order"

#define GetTryCard      @"/app/experienceCar/getMyExperienceCar"
#define AddTryCard      @"/app/experienceCar/add"

#define BindInviteCode  @"/app/user/bindInvitationCode"

#pragma mark - Get
#define GetGameInfo     @"/app/game/getSysGames"
#define GetInviteCode   @"/app/user/getInvitationCode"

#define Error_UnKnown   333
