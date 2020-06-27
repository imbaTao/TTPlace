//
//  YNFormAddNumbDetailController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormAddNumbDetailController.h"

@interface YNFormAddNumbDetailController ()<UITextFieldDelegate>
/**
 输入内容
 */
@property(nonatomic, readwrite, strong)UITextField *inputTextFiled;

@end


#define LETTER @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMBER @"0123456789"
@implementation YNFormAddNumbDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(244, 247, 249, 1);
    self.navigationController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(doneAction) title:@"完成" font:[UIFont mediumFontSize:16] titleColor:rgba(255, 39, 66, 1) highlightedColor:rgba(255, 39, 66, 1) titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    
    
    UILabel *titleLabel = [UILabel regularFontWithSize:13 color:rgba(102, 102, 102, 1)];
    titleLabel.text = @"添加号是账号的唯一凭证，只能修改一次";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(19);
        make.top.offset(13);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(titleLabel.mas_bottom).offset(11);
        make.height.offset(42);
    }];
    
    self.inputTextFiled = [[UITextField alloc] init];
    self.inputTextFiled.textColor  = rgba(51, 51, 51, 1);
    self.inputTextFiled.tintColor = rgba(255, 0, 0, 1);
    self.inputTextFiled.placeholder = @"添加号";
    [containerView addSubview:self.inputTextFiled];
    self.inputTextFiled.delegate = self;
    self.inputTextFiled.returnKeyType = UIReturnKeyDone;
    self.inputTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    [self.inputTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(19);
        make.right.offset(-19);
        make.centerY.equalTo(containerView);
        make.height.offset(20);
    }];
    
    UILabel *ruleLabel = [UILabel regularFontWithSize:13 color:rgba(102, 102, 102, 1)];
    ruleLabel.text = @"6-15个字符，仅可使用英文（必须）、数字、下划线";
    [self.view addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTextFiled);
        make.top.equalTo(containerView.mas_bottom).offset(11);
    }];
    
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    });
#endif
    
    @weakify(self);
    [[self.inputTextFiled rac_textSignal] subscribeNext:^(NSString * _Nullable string) {
        @strongify(self);
        if (string.length > 15) {
            string = [string substringWithRange:NSMakeRange(0, 15)];
        }
        self.inputTextFiled.text = string;
        HTLog(@"内容改变了%@",string);
    }];
    
 
//    inputTextFiled.text = @"12asasada_我";
//    HTLog( @"%zd结果 ---- ",[self checkInputValid:inputTextFiled.text]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField == self.mTFUserName)
//    {
//        [self.mTFPassWord becomeFirstResponder];
//    }else if (textField == self.mTFPassWord){
//        [self  mBTLogin:self.BTLogin];
//    }
    return [self doneAction];;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //大小写字符限制
    NSCharacterSet *charcterSet = [[NSCharacterSet characterSetWithCharactersInString:LETTER] invertedSet];
    NSString *charcterFiltered = [[string componentsSeparatedByCharactersInSet:charcterSet] componentsJoinedByString:@""];
    
    //数字限制
    NSCharacterSet *numSet = [[NSCharacterSet characterSetWithCharactersInString:NUMBER] invertedSet];
    NSString *numFiltered = [[string componentsSeparatedByCharactersInSet:numSet] componentsJoinedByString:@""];
    
    // 允许的字符
    NSCharacterSet *lineSet = [NSCharacterSet characterSetWithCharactersInString:@"_"];
       // 内容条件的反转
//     NSCharacterSet *forbiddenSet = [allowedSet invertedSet];
     
     // 是否能找到其他字符
     BOOL result = [string rangeOfCharacterFromSet:lineSet].location != NSNotFound;
    
    return ([string isEqualToString:charcterFiltered] || [string isEqualToString:numFiltered] || result);
}

- (BOOL)checkInputValid:(NSString *)string {
    // 允许的字符
    NSMutableCharacterSet *allowedSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"_"];

    // 所有的数字和大小写字母
    [allowedSet formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
    
    // 内容条件的反转
    NSCharacterSet *forbiddenSet = [allowedSet invertedSet];
    
    // 是否能找到字符
    NSRange r = [string rangeOfCharacterFromSet:forbiddenSet];
    if (r.location != NSNotFound) {
        return false;
    }else {
        return true;
    }
}

// 热刷新UI代码，不用可以注释掉，不调用
- (void)hotReload {
    [self removeAllViews:self.view];
    [self viewDidLoad];
}

// 热刷新UI代码，不用可以注释掉，不调用
- (void)removeAllViews:(UIView *)view {
    while (view.subviews.count) {
        UIView* child = view.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (BOOL)doneAction {
    if (self.inputTextFiled.text.length >= 6) {
        
        // 网络请求修改
        return true;
    }else {
        // 显示错误提示
        HTShowError(@"添加号长度最低需6个字符~");
        return false;
    }
}

@end
