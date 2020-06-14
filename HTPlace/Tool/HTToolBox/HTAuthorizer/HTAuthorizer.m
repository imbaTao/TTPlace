//
//  HTAuthorizer.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/22.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTAuthorizer.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface HTAuthorizer()<UIAlertViewDelegate>
@end
@implementation HTAuthorizer

- (UIWindow *)ht_KeyWindow {
   if (@available(iOS 13.0, *)) {
        return [UIApplication sharedApplication].windows.firstObject;
    }else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

// 获取相机权限
+ (void)fechCameraAuthorizationStatus:(void (^)(BOOL result))resultBlock{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        // 无权限显示权限弹窗
        [self p_showSettingTipsWithType:1];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (!granted) {
                [self p_showSettingTipsWithType:1];
            }
             resultBlock(granted);
        }];
    } else {
        resultBlock(true);
    }
}

// 获取相册权限
+ (void)fechPhotoLibraryAuthorizationStatus:(void (^)(BOOL result))resultBlock{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if ((status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)) {
            // 无权限显示权限弹窗
            [self p_showSettingTipsWithType:2];
        } else if (status == PHAuthorizationStatusNotDetermined) {
             resultBlock(false);
        } else {
            resultBlock(true);
        }
    }];
}

// 展示前往设置界面的面板
+ (void)p_showSettingTipsWithType:(NSInteger)type {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *infoDict = [self getInfoDictionary];
        // 提示
        NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleExecutable"];
        NSString  *title = @"无法使用相机";
        NSString *message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"中允许%@访问相机",appName];
        if (type == 2) {
            title = @"无法访问相册";
            message = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相册\"中允许%@访问相册",appName];;
        }
        
        UIAlertController *alertViewVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        [alertViewVC addAction:cancleAction];
        [alertViewVC addAction:settingAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertViewVC animated:true completion:nil];
    });
}



// 获得Info.plist数据字典
+ (NSDictionary *)getInfoDictionary {
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return infoDict ? infoDict : @{};
}
@end
