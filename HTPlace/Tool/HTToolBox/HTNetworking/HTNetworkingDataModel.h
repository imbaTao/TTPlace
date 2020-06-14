//
//  HTNetworkingDataModel.h
//  HTPlace
//
//  Created by hong on 2019/12/24.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTNetworkingDataModel : NSObject

/**
 装请求的data
 */
@property(nonatomic, readwrite, strong)id data;

/**
 除data ,message, code以外的别的数据
 */
@property(nonatomic, readwrite, strong)id otherData;

/**
 请求返回的信息
 */
@property(nonatomic, readwrite, copy)NSString *message;

/**
 请求返回的code
 */
@property(nonatomic, readwrite, assign)NSInteger code;

/**
 返回储存错误
 */
@property(nonatomic, readwrite, strong)NSError *error;


/**
 请求是否通了
 */
@property(nonatomic, readwrite, assign)BOOL isClear;

/**
 是否是最终成功的 (code值可能不为200等，不算最终成功)
 */
@property(nonatomic, readwrite, assign)BOOL isFinalSuccess;

/**
 分析结果
 */
//- (void)fetchReuslt:(void(^)(NSInteger code))result;



///**
// 转换出字典模型
// */
//- (id)modelsWithClass:(NSObject )ClassName;


/**
 想法
 
 给一个想转出的模型类型，然后直接转出模型数组,方便快捷
 */
@end

NS_ASSUME_NONNULL_END
