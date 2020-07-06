//
//  YNFormAboutInfoDetailController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormAboutInfoDetailController.h"

@interface YNFormAboutInfoDetailController ()<UITextViewDelegate>
/**
 编辑的textView
 */
@property(nonatomic, readwrite, strong)UITextView *textView;

/**
 placeHolder
 */
@property(nonatomic, readwrite, strong)UILabel *placeholder;


@end

@implementation YNFormAboutInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *containerView = [UIView viewWithColor:[UIColor whiteColor]];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(9);
        make.height.offset(ver(125));
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont fontSize:14];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.tintColor = self.textView.textColor = rgba(51, 51, 51, 1);
    [containerView addSubview:self.textView];
    [self.textView becomeFirstResponder];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(16, 16, 16, 16));
    }];
    
    self.placeholder = [UILabel size:14 color:rgba(102, 102, 102, 1) textAlignment:NSTextAlignmentLeft placeholder:@"请输入50字符以内的内容"];
    [self.textView addSubview:self.placeholder];
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(6);
    }];
    
    @weakify(self);
    [[self.textView rac_textSignal] subscribeNext:^(NSString * _Nullable string) {
        @strongify(self);
        if (string.length > 50) {
            string = [string substringWithRange:NSMakeRange(0, 50)];
             HTShowError(@"请输入50字符以内~");
        }
        self.textView.text = string;
        self.placeholder.hidden = self.textView.text.length;
    }];
    
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    });
#endif
    
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text

{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self doneAction];
        return NO;
    }
    return YES;
}

- (void)doneAction {
    HTLoading;
    
    // 网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self finishEditAction:self.textView.text];
    });
}


- (void)finishEditAction:(NSString *)content {
    
}

@end
