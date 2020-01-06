//
//  JHGOrderInpuPasswordView.m
//  HTPlace
//
//  Created by hong on 2019/12/5.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "JHGOrderInpuPasswordView.h"

@implementation JHGOrderInpuPasswordViewCell

- (void)setupUI {
    self.blackPoint = [UIView viewWithColor:rgba(0, 0, 0, 1) cornerRadius:13 / 2];
    self.blackPoint.hidden = true;
    
    @weakify(self);
    [self setupLayout:^{
        @strongify(self);
        [self.blackPoint centerWithReferView:self size:CGSizeMake(13, 13)];
    }];
}

- (void)setModel:(JHGOrderInpuPasswordModel *)model {
    _model = model;
    
    // 没有添加过边框
    if (!self.hasBorder) {
        [self configBorder:model.index];
        self.hasBorder = true;
        
        @weakify(self);
        [RACObserve(self.model, hasValue) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            BOOL value = [x boolValue];
            self.blackPoint.hidden = !value;
        }];
    }
}

// 设置边框
- (void)configBorder:(NSInteger)index {
    switch (index) {
        case 0:{
            for (NSInteger i = 0; i < 4; i++) {
                UIView *border = [UIView viewWithColor:rgba(215, 215, 215, 1)];
                [self addSubview:border];
                switch (i) {
                    case 0:{
                        // 上
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.left.offset(0);
                            make.right.offset(0);
                            make.height.offset(0.5);
                        }];
                    }break;
                    case 1:{
                        // 左
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.offset(0);
                            make.top.bottom.offset(0);
                            make.width.offset(0.5);
                        }];
                    }break;
                    case 2:{
                        // 下
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.bottom.left.offset(0);
                            make.right.offset(0);
                            make.height.offset(0.5);
                        }];
                    }break;
                    case 3:{
                        // 右
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.offset(0);
                            make.top.bottom.offset(0);
                            make.width.offset(0.5);
                        }];
                    }break;
                }
            }
        }break; // 如果是第一次和最后一次要循环4次
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:{
            for (NSInteger i = 0; i < 3; i++) {
                UIView *border = [UIView viewWithColor:rgba(215, 215, 215, 1)];
                [self addSubview:border];
                switch (i) {
                    case 0:{
                        // 上
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.left.right.offset(0);
                            make.height.offset(0.5);
                        }];
                    }break;
                    case 1:{
                        // 下
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.bottom.left.right.offset(0);
                            make.height.offset(0.5);
                        }];
                    }break;
                    case 2:{
                        // 右
                        [border mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.bottom.right.offset(0);
                            make.width.offset(0.5);
                        }];
                    }break;
                }
            }
        }break;
        default:break;
    }
}

@end

@interface JHGOrderInpuPasswordView()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 分割线
 */
@property(nonatomic, readwrite, strong)UIView *sgline;


@end

@implementation JHGOrderInpuPasswordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self settingCornerRadius:5.0];
        
        self.inputTF = [[UITextField alloc] init];
        self.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        self.inputTF.hidden = true;
        self.closeButton = [UIButton iconName:@"JHGOrder_1"];
        self.inputTitle = [UILabel font:[UIFont boldFontSize:16] color:rgba(51, 51, 51, 1) textAlignment:NSTextAlignmentCenter placeholder:@"请输入支付密码"];
        self.sgline = [UIView viewWithColor:rgba(229, 229, 229, 1)];
        self.tips = [UILabel size:13 color:rgba(119, 119, 119, 1) textAlignment:NSTextAlignmentCenter placeholder:@"您使用了余额资产，需要验证"];
        
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout creatWithLineSpacing:0 InteritemSpacing:0 itemCount:6 sectionInset:UIEdgeInsetsMake(0, 0, 0, 0) sourceSize:CGSizeMake(45, 45) needChangeSize:false scrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.passworldTable = [[HTCommonCollectionView alloc] initWithlayout:layout cellClassNames:@[@"JHGOrderInpuPasswordViewCell"] delegateTarget:self];
        NSMutableArray *passModelArray = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            JHGOrderInpuPasswordModel *model = [[JHGOrderInpuPasswordModel alloc] init];
            model.index = i;
            [passModelArray addObject:model];
        }
        self.passworldTable.data = passModelArray;
        self.passworldTable.scrollEnabled = false;
        
        self.settingButton = [[HTFickleButton alloc] initWithHorizontalRotationButtonWithTitle:@"忘记密码" font:[UIFont fontSize:14] normalColor:rgba(222, 49, 33, 1) imgName:@"JHGOrder_2"];
        
        // layout
        @weakify(self);
        [self setupLayout:^{
            @strongify(self);
            [self.inputTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.baseline.equalTo(self.mas_top).offset(19.5 + 15.5);
                make.centerX.equalTo(self);
            }];
            
            [self.closeButton centerYWithReferView:self.inputTitle rihgt:20];
            [self.sgline left:0 right:0 top:15 height:0.5 referView:self.inputTitle];
            [self.tips left:0 right:0 baseLineTop:30 referView:self.sgline];
            
            [self.passworldTable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15);
                make.right.offset(-15);
                make.top.equalTo(self.tips.mas_baseline).offset(15);
                make.height.offset(45);
            }];
            
//            self.inputTF.hidden = false;
//            self.inputTF.backgroundColor = [UIColor redColor];
            [self.inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(0);
                make.left.right.offset(0);
                make.height.offset(45);
            }];
            
            
            
            [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(-24);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(73, 13));
            }];
        }];
        
        
        // rac
        [self racConfig];
    }
    return self;
}

- (void)racConfig {
    // 只能输入6个
    @weakify(self);
    [[[self.inputTF.rac_textSignal map:^id(NSString *value) {
        return @(value.length);
    }] filter:^BOOL(id value) {
        return [value intValue] > 6;
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.inputTF.text = [self.inputTF.text substringToIndex:6];
    }];

    
    [self.inputTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (self.inputTF.text.length <= 6) {
            [self disposePasswordText];
            
            // 长度到了就验证密码
            if (self.inputTF.text.length == 6) {
                [self passworldVerify];
            }
        }
    }];
}

// 密码长度到了验证
- (void)passworldVerify {
    
}


// 处理密码文本
- (void)disposePasswordText {
    for (int i = 0; i < 6; i++) {
        JHGOrderInpuPasswordModel *model = self.passworldTable.data[i];
        
        // 如果长度为0 默认都是false
        if (!self.inputTF.text.length) {
            model.hasValue = false;
        }else if (model.index < self.inputTF.text.length) {
            // 如果下标小于总长度就是输入了
            model.hasValue = true;
        }else {
            // 否则就是还没输入到
            model.hasValue = false;
        }
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}


- (JHGOrderInpuPasswordViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JHGOrderInpuPasswordViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.passworldTable.cellClassNames.firstObject forIndexPath:indexPath];
    cell.model = self.passworldTable.data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.inputTF becomeFirstResponder];
}



@end

