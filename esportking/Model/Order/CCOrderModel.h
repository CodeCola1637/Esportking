//
//  CCOrderModel.h
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ORDERSTAUTS_WAIT = 1,
    ORDERSTAUTS_DOING,
    ORDERSTAUTS_COMMENT,
    ORDERSTAUTS_COMPLETED,
    ORDERSTAUTS_CANCELED,
} ORDERSTAUTS;

typedef enum : NSUInteger {
    ORDERPAYSTAUTS_WAITPAY = 1,
    ORDERPAYSTAUTS_ALREADYPAY,
    ORDERPAYSTAUTS_FAILPAY,
    ORDERPAYSTAUTS_BACKPAY,
} ORDERPAYSTAUTS;

@interface CCOrderModel : NSObject

@property (assign, nonatomic) ORDERDISPLAYSTATUS displayStatus;

@property (strong, nonatomic) NSString *orderID;
@property (assign, nonatomic) ORDERSTAUTS status;
@property (assign, nonatomic) ORDERPAYSTAUTS payStatus;
@property (assign, nonatomic) uint32_t money;

@property (assign, nonatomic) SCORESTYLE style;
@property (assign, nonatomic) CLIENTTYPE clientType;
@property (assign, nonatomic) PLATFORM platformType;

@property (assign, nonatomic) uint64_t senderID;
@property (strong, nonatomic) NSString *senderName;

@property (assign, nonatomic) uint64_t receiverID;
@property (strong, nonatomic) NSString *receiverName;

@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *danStr;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
