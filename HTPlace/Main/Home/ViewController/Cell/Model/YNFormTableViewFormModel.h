//
//  YNFormTableViewFormModel.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, YNFormTableViewFormModelType) {
    YNFormTableViewFormModelTypeDefault = 0,
    YNFormTableViewFormModelTypePush,
    
};

@interface YNFormTableViewFormModel : NSObject

/**
 类型
 */
@property(nonatomic, readwrite, assign)YNFormTableViewFormModelType type;


/**
 标题
 */
@property(nonatomic, readwrite,copy)NSString *title;


/**
 内容
 */
@property(nonatomic, readwrite, copy)NSString *content;

/**
 占位内容
 */
@property(nonatomic, readwrite, copy)NSString *placeholder;


/**
 内容
 */
@property(nonatomic, readwrite, copy)NSMutableAttributedString *attributedTitle;


/**
 初始化方法
 */
+(instancetype)modelWithTitle:(nonnull NSString *)title attributedTitle:(nullable NSMutableAttributedString *)attributedTitle content:(nullable NSString *)content type:(YNFormTableViewFormModelType)type placeholder:(nonnull NSString *)placeholder ;

@end

NS_ASSUME_NONNULL_END
