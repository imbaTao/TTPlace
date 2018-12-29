//
//  LittleBox-TakeAttributeByString.h
//  HZYToolBox
//
//  Created by hong  on 2018/12/19.
//  Copyright © 2018 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LittleBox_TakeAttributeByString : NSObject
// 根据后台给的字段生成属性列表并打印
+ (void)takeAttributeByString;

+ (void)takeWords;

// 填充模型属性
+ (void)takeModelWords;

// 从数据库查询语句
+ (void)takeSearchWords;

// 获取复制
+ (void)takeCopyWords;
@end

NS_ASSUME_NONNULL_END
