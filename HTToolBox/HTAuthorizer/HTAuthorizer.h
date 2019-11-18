//
//  HTAuthorizer.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/22.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTAuthorizer : NSObject

/**
 监测相机权限
 @param resultBlock 返回的结果 true 为可用，false为不可用
 */
+ (void)fechCameraAuthorizationStatus:(void(^)(BOOL result))resultBlock;

/**
 获取相册权限
 */
+ (void)fechPhotoLibraryAuthorizationStatus:(void (^)(BOOL result))resultBlock;
@end

NS_ASSUME_NONNULL_END
