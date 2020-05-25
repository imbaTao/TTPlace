//
//  NSString+HTPrice.h
//  Jihuigou-Native
//
//  Created by hong on 2020/4/29.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTPrice)

// 处理价格有小数保留小数，无小数剔除0
+ (NSString *)disposePrice:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
