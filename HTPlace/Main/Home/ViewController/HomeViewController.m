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

