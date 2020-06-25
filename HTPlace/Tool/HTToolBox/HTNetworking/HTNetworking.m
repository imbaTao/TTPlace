//
//  HTNetworking.m
//  HTPlace
//
//  Created by hong on 2019/12/24.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "HTNetworking.h"
#import "HTNetworkingDataModel.h"

@interface HTNetworking ()

/**
 环境
 */
@property(nonatomic, readwrite, assign)HTNetworkingEnvironment netEnvironment;

/**
 域名
 */
@property(nonatomic, readwrite, copy)NSString *domain;

/**
 授权头,一般是公司的token验证
 */
@property(nonatomic, readwrite, copy)NSString *authorizeContent;

/**
 公司返回数据约定的data的键
 */
@property(nonatomic, readwrite, copy)NSString *dataKey;

/**
 公司返回数据约定的message的键
 */
@property(nonatomic, readwrite, copy)NSString *messageKey;

/**
 公司返回数据约定的code的键
 */
@property(nonatomic, readwrite, copy)NSString *codeKey;

/**
 公司返回数据约定的code的键
 */
@property(nonatomic, readwrite, assign)NSInteger successCode;

@end

@implementation HTNetworking
singleM()

/**
 在appDelegate里初始化
 要传必要参数 域名  data,msg,code key 成功码
 */
+ (void)setupNetworkingWithDomainModel:(HTNetworkingDomainModel *)domainModel dataKeys:(NSString *)dataKey messageKey:(NSString *)messageKey codeKey:(NSString *)codeKey successCode:(NSInteger)successCode netEnvironment:(HTNetworkingEnvironment)netEnvironment{

    // 根据不同环境配置不同的域名
    switch (netEnvironment) {
        case HTNetworkingEnvironmentLocal:{
            HTNET.domain = domainModel.localDomain;
        }break;
        case HTNetworkingEnvironmentTest:{
            HTNET.domain = domainModel.testDomain;
        }break;
        case HTNetworkingEnvironmentRelease:{
            HTNET.domain = domainModel.releaseDomain;
        }break;
    }

    HTNET.netEnvironment = netEnvironment;
    HTNET.dataKey = dataKey;
    HTNET.messageKey = messageKey;
    HTNET.codeKey = codeKey;
    HTNET.successCode = successCode;
}

#pragma mark - get请求
+ (void)getWithParams:(NSMutableDictionary *)params url:(NSString *)url result:(void(^)(id))resultBlock{
    [HTNET.manager GET:[self disposeUrl:url] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 处理成功的模型
       resultBlock([self disposeResponseObject:responseObject task:task]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 处理失败的模型
        HTNetworkingDataModel *failerModel = [[HTNetworkingDataModel alloc] init];
        failerModel.error = error;
        resultBlock(failerModel);
    }];
}

#pragma mark - Rac处理方式
+ (RACSignal *)getWithParams:(NSMutableDictionary *)params url:(NSString *)url{
    return ([RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         HTLog(@"当前请求接口：%@ 当前请求参数：%@",url,params);
        // get请求
        [HTNET.manager GET:[self disposeUrl:url] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            // 处理数据模型
            HTNetworkingDataModel *model = [self disposeResponseObject:responseObject task:task];

            // 如果最终请求成功
            if (model.isFinalSuccess) {
                [subscriber sendNext:model];
            }else {
                // 这里是code不同返回error
                // 一般操作是展示错误信息
                // HUD(model.message);
                [subscriber sendError:task.error];
            }

            // 结束订阅
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 处理失败的模型,结束订阅
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }]);
}

+ (RACSignal *)postWithParams:(NSMutableDictionary *)params url:(NSString *)url{
    HTLog(@"当前请求接口：%@ 当前请求参数：%@",url,params);
    return ([RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // get请求
        [HTNET.manager POST:[self disposeUrl:url] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            // 处理数据模型
            HTNetworkingDataModel *model = [self disposeResponseObject:responseObject task:task];

            // 如果最终请求成功
            if (model.isFinalSuccess) {
                [subscriber sendNext:model];
            }else {
                // 这里是code不同返回error
                // 一般操作是展示错误信息
                // HUD(model.message);
                [subscriber sendError:task.error];
            }

            // 结束订阅
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 处理失败的模型,结束订阅
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }]);
}

+ (HTNetworkingDataModel *)disposeResponseObject:(id _Nullable)responseObject task:(NSURLSessionTask *)task {
    // 创建返回模型
    HTNetworkingDataModel *model = [[HTNetworkingDataModel alloc] init];

    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
//        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        
        model.code = [responseObject[HTNET.codeKey] integerValue];
        
          // 消息字段
        NSString *message = [NSString stringWithFormat:@"%@",responseObject[HTNET.messageKey]];

         // 如果取到了消息字段
         if (message.hasValue) {
             model.message = message;
         }else {
             model.message = @"HT框架提示,请检查与后台约定的消息字段的key设置";
         }

         // 拿到返回的请求码,如果请求码跟约定的成功码是相同的,那么就是成功的
         if (model.code == HTNET.successCode) {
             model.isFinalSuccess = true;

             // 如果按照约定的dataKey取值有值
             NSDictionary *data = responseObject[HTNET.dataKey];
             if (data) {
                 model.data = data;
             }else {
                // 无值赋值otherData
                 model.otherData = responseObject;
             }
         }else {
             // 返回码不同
             model.isFinalSuccess = false;
             model.otherData = responseObject;
         }
    }
    return model;
}

// 处理url,防止url不带域名
+ (NSString *)disposeUrl:(NSString *)url {
    if (![url containsString:@"http"]) {
        return [NSString stringWithFormat:@"%@%@",HTNET.domain,url];
    }
    return url;
}




#pragma mark - Setter && Getter
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [HTNetworking p_setupManager];
    }
    return _manager;
}

// 初始化请求管理者和设置
+ (AFHTTPSessionManager *)p_setupManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // 超时时间
    manager.requestSerializer.timeoutInterval = 5;

    // Json解析器
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    // 响应解析器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    // 授权
    if (HTNET.authorizeContent.length) {
//        [manager.requestSerializer setValue:HTNET.authorizeContent forHTTPHeaderField:@"Authorize"];
        
    }
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] forHTTPHeaderField:@"token"];
    
    return manager;
}
@end
