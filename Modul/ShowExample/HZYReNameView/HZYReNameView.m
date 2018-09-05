//
//  HZYReNameView.m
//  HZYToolBox
//
//  Created by hong  on 2018/9/5.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYReNameView.h"
@interface HZYReNameView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleNameLB;
@property (weak, nonatomic) IBOutlet UILabel *sourceTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *sourceContentLB;
@property (weak, nonatomic) IBOutlet UITextField *changeTitleTF;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@end

@implementation HZYReNameView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.alpha = 0;
    _titleNameLB.text = @"重命名";
    _sourceTitleLB.text = @"原标题:";
    _changeTitleTF.placeholder = @"请输入新的文件名";
    _sourceContentLB.lineBreakMode =  NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    _centerView.layer.cornerRadius = 8;
    _centerView.layer.shadowOffset = CGSizeMake(1, 2);
    _centerView.layer.shadowOpacity = 0.1;
}

#pragma mark - UITextFieldAction
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Response
- (IBAction)cancleAction:(id)sender {
    [self hid];
}

- (IBAction)OKAction:(UIButton *)sender {
    if (_changeTitleTF.text.length) {
        [self.delegate finishChangeFileName:_changeTitleTF.text];
    }
}


#pragma mark - private
- (void)showWithSourceName:(NSString *)sourceName{
    _sourceContentLB.text = sourceName;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)hid{
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
         weakself.changeTitleTF.text = @"";
    }];
}
@end
