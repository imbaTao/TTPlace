//
//  HTNetworking.h
//  HTPlace
//
//  Created by hong on 2019/12/24.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTNetworkingDomainModel.h"
#import "HTNetworkingDataModel.h"
NS_ASSUME_NONNULL_BEGIN

#define HTNET [HTNetworking share]


typedef NS_OPTIONS(NSInteger, HTNetworkingEnvironment) {
    HTNetworkingEnvironmentLocal = 0, // 本地域名环境
    HTNetworkingEnvironmentTest,// 测试域名
    HTNetworkingEnvironmentRelease,// 正式线上域名
};

@class HTNetworkingDomainModel;
@interface HTNetworking : NSObject
singleH();



/**
 封装网络请求管理类
 基层是对AFNetworking的二次封装方便使用
 初步思想，写一套基础的，另一套是结合RAC使用的
 
 
 
 
 请求方式，get post
 传参问题
 请求结果回调问题
 通用解析问题
 下载上传图片等资源问题
 */



/**
 请求管理者
 */
@property(nonatomic, readwrite, strong)AFHTTPSessionManager *manager;

/**
 授权头,一般是公司的token验证
 */
@property(nonatomic, readonly, copy)NSString *authorizeContent;

/**
 公司返回数据约定的data的键
 */
@property(nonatomic, readonly, copy)NSString *dataKey;

/**
 公司返回数据约定的message的键
 */
@property(nonatomic, readonly, copy)NSString *messageKey;

/**
 公司返回数据约定的code的键
 */
@property(nonatomic, readonly, copy)NSString *codeKey;

/**
 公司返回数据约定的code的键
 */
@property(nonatomic, readonly, assign)NSInteger successCode;

/**
 必要 域名@{
  1.本地域名
  2.测试域名
  3.正式域名
 } data,msg,code key 成功code
 */

+ (void)setupNetworkingWithDomainModel:(nonnull HTNetworkingDomainModel *)domainModel dataKeys:(nullable NSString *)dataKey messageKey:(nullable NSString *)messageKey codeKey:(nullable NSString *)codeKey successCode:(NSInteger)successCode netEnvironment:(HTNetworkingEnvironment)netEnvironment;

/**
 get 请求
 */
+ (RACSignal *)getWithParams:(nullable NSMutableDictionary *)params url:(NSString *)url;

/**
 post 请求
 */
+ (RACSignal *)postWithParams:(nullable NSMutableDictionary *)params url:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
