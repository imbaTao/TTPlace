//
//  YNFormTableViewCell.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormTableViewCell.h"

@implementation YNFormTableViewCell

- (void)setupUI {
    [self titleLable];
    [self inputTextFiled];
    [self segementLine];
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel size:12 color:rgba(102, 102, 102, 1) textAlignment:NSTextAlignmentLeft placeholder:@""];
        [self addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(56);
            make.right.offset(-56);
        }];
    }
    return _titleLable;
}

- (UITextField *)inputTextFiled {
    if (!_inputTextFiled) {
        _inputTextFiled = [[UITextField alloc] init];
        _inputTextFiled.placeholder = @"请设置相关信息";
        _inputTextFiled.font = [UIFont fontSize:14];
        _inputTextFiled.autocorrectionType = UITextAutocorrectionTypeNo;//不开启自动更正功能
        _inputTextFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母不大写
        _inputTextFiled.tintColor = rgba(255, 0, 0, 1);//光标颜色
        
        [self addSubview:_inputTextFiled];
        [_inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLable);
            make.bottom.offset(-3);
            make.height.offset(20);
        }];
    }
    return _inputTextFiled;
}

- (UIButton *)eventButton {
    if (!_eventButton) {
        _eventButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _inputTextFiled.userInteractionEnabled = false;
//        _eventButton.backgroundColor = [UIColor redColor];
//        _inputTextFiled.enabled = false;
        [self addSubview:_eventButton];
        [_eventButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.inputTextFiled);
        }];
    }
    return _eventButton;
}

- (UIView *)segementLine {
    if (!_segementLine) {
        _segementLine = [[UIView alloc] init];
        _segementLine.backgroundColor = rgba(224, 226, 231, 1);
        [self addSubview:_segementLine];
        [_segementLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLable);
            make.bottom.offset(0);
            make.height.offset(1);
        }];
    }
    return _segementLine;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_push"]];
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.segementLine).offset(-15);
            make.centerY.equalTo(self.inputTextFiled);
        }];
    }
    return _rightImageView;
}

@end
