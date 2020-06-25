//
//  YNFormTableViewFormModel.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormTableViewFormModel.h"

@implementation YNFormTableViewFormModel

+ (instancetype)modelWithTitle:(NSString *)title attributedTitle:(NSMutableAttributedString *)attributedTitle content:(NSString *)content type:(YNFormTableViewFormModelType)type placeholder:(NSString *)placeholder {
    YNFormTableViewFormModel *model = [[YNFormTableViewFormModel alloc] init];
    model.title = title;
    model.attributedTitle = attributedTitle;
    model.content = content;
    model.type =  type;
    model.placeholder = placeholder;
    return model;
}

- (NSString *)content {
    if (!_content.length) {
        return @"";
    }
    return _content;
}
@end
