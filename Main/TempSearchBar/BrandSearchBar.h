//
//  BrandSearchBar.h
//  HTPlace
//
//  Created by hong on 2020/1/6.
//  Copyright © 2020 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BrandSearchBar : UIView

@property (nonatomic, copy) NSString *searchPlaceholder;//搜索占位文字

@property (nonatomic, strong) UITextField *searchTF;//输入框

@property (nonatomic, strong) UIImageView *searchImageV;//搜索图标
@end

NS_ASSUME_NONNULL_END
