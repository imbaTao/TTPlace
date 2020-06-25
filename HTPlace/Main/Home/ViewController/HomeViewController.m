//
//  HomeViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeViewSub.h"
#import "HomeViewControllerViewModel.h"
#import "YNFormTableViewCell.h"
#import "YNFormGenderTableViewCell.h"
@implementation HomeViewController
@synthesize vm = _vm;

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 200)];
    
    self.vm.data = @[
        [YNFormTableViewFormModel modelWithTitle:@"姓名" attributedTitle:nil content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"请填写您的姓名"],
        [YNFormTableViewFormModel modelWithTitle:@"性别" attributedTitle:nil content:@"1" type:YNFormTableViewFormModelTypeDefault placeholder:@"请填写您的性别"],
        [YNFormTableViewFormModel modelWithTitle:@"生日" attributedTitle:nil content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"请填写您的生日"],
        [YNFormTableViewFormModel modelWithTitle:@"添加号" attributedTitle:[[NSMutableAttributedString alloc]initWithString:@"*添加号(确定后无法更改)"] content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"添加号信息,确定后无法更改"],
        [YNFormTableViewFormModel modelWithTitle:@"长居住地" attributedTitle:nil content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"完善你的地理位置"],
        [YNFormTableViewFormModel modelWithTitle:@"大学" attributedTitle:[[NSMutableAttributedString alloc]initWithString:@"*大学"] content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"添加学校，寻找你的朋友"],
        [YNFormTableViewFormModel modelWithTitle:@"专业" attributedTitle:nil content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"请填写您的专业"],
        [YNFormTableViewFormModel modelWithTitle:@"关于" attributedTitle:nil content:@"" type:YNFormTableViewFormModelTypeDefault placeholder:@"关于..."],
    ];
    
    
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

- (YNFormTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YNFormTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    YNFormTableViewFormModel *model = [self.vm modelDataWithIndexPath:indexPath];
    if (!cell) {
        if (indexPath.section !=1 ) {
            cell = [[YNFormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self.vm cellIdentiyferWithIndexPath:indexPath]];
        }else {
             cell = [[YNFormGenderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self.vm cellIdentiyferWithIndexPath:indexPath]];
        }
    }
    
    // 设置标题
    if (model.attributedTitle.length) {
         cell.titleLable.attributedText = model.attributedTitle;
    }else {
         cell.titleLable.text = model.title;
    }
   
    
    // 如果不是第二行性别行
    if (indexPath.section != 1) {
        cell.inputTextFiled.text = model.content;
        cell.inputTextFiled.placeholder = model.placeholder;
    }
    
    // 要push的
    if ([@[@2,@4,@5,@7] containsObject:@(indexPath.section)]) {
        cell.rightImageView.hidden = false;
    }
    
    switch (indexPath.section) {
        case 1:{
            YNFormGenderTableViewCell *genderCell = (YNFormGenderTableViewCell *)cell;
            genderCell.model = model;
        }break;
        case 2:{
            // 生日行点击
            [[[cell.eventButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
             
            }];
        }break;
        case 4:{
            // 居住地点击
            [[[cell.eventButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
             
            }];
        }break;
        case 5:{
            // 大学点击
            [[[cell.eventButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
            }];
        }break;
        case 7:{
            cell.segementLine.hidden = true;
            // 关于点击
            [[[cell.eventButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                
            }];
        }break;
        default:break;
    }
    return cell;
}


- (HTCommonTableViewModel *)vm {
    if (!_vm) {
        _vm = [[HomeViewControllerViewModel alloc] init];
    }
    return _vm;
}

@end

