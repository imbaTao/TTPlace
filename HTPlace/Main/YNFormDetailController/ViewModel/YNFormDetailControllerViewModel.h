//
//  YNFormDetailControllerViewModel.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, FormDetailType) {
    FormDetailTypeNumb = 0,// 添加号
    FormDetailTypeLocation,// 地理位置位置
    FormDetailTypeCollege,// 大学
    FormDetailTypeProfession,//专业
    FormDetailTypeAbout,// 关于
};
@interface YNFormDetailControllerViewModel : NSObject

@end

NS_ASSUME_NONNULL_END
