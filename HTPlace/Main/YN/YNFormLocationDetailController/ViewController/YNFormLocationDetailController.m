//
//  YNFormLocationDetailController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormLocationDetailController.h"
#import "YNFormLocationDetailControllerViewModel.h"
#import "YNFormLocationDetailCell.h"

@interface YNFormLocationDetailController ()
/**
 vm
 */
@property(nonatomic, readwrite, strong)YNFormLocationDetailControllerViewModel *vm;

@end

@implementation YNFormLocationDetailController
@synthesize vm = _vm;

- (YNFormLocationDetailControllerViewModel *)vm {
    if (!_vm) {
        _vm = [[YNFormLocationDetailControllerViewModel alloc] init];
    }
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置头部视图
    [self configHeaderView];

#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    });
#endif
}

- (void)configHeaderView {
    // 如果定位到了
      if (self.vm.locationCityName.length) {
          UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 84)];
          containerView.backgroundColor = rgba(244, 247, 249, 1);
          UILabel *titleLable = [UILabel regularFontWithSize:13 color:rgba(102, 102, 102, 1)];
          titleLable.text = @"定位到的位置";
          [containerView addSubview:titleLable];
          [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.offset(19);
              make.top.offset(13);
          }];
          
          UIView *whiteRowView = [[UIView alloc] init];
          whiteRowView.backgroundColor = [UIColor whiteColor];
          [containerView addSubview:whiteRowView];
          [whiteRowView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.bottom.offset(0);
              make.height.offset([self.vm heightOfRow:[NSIndexPath indexPathWithIndex:0]]);
          }];
          [containerView addSubview:whiteRowView];
          
          
          // 地图icon
          UIButton *mapIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
          [mapIconButton setTitle:self.vm.locationCityName forState:UIControlStateNormal];
          mapIconButton.titleLabel.font = [UIFont mediumFontSize:14];
          [mapIconButton setTitleColor:rgba(51, 51, 51, 1) forState:UIControlStateNormal];
          mapIconButton.userInteractionEnabled = false;
          [mapIconButton setImage:[UIImage imageNamed:@"icon_addr_gray"] forState:UIControlStateNormal];
          [mapIconButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
          [whiteRowView addSubview:mapIconButton];
          [mapIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.offset(19);
              make.centerY.equalTo(whiteRowView);
          }];
          self.tableView.tableHeaderView = containerView;
//          [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.left.right.top.offset(0);
//              make.height.offset(84);
//          }];
      }
}

- (void)configureCell:(YNFormLocationDetailCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    YNFormLocationDetailControllerModel *model = [self.vm modelDataWithIndexPath:indexPath];
    cell.contentLabel.text = model.lists[indexPath.row];
    cell.segementLine.hidden = indexPath.row == model.lists.count - 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     YNFormLocationDetailControllerModel *model = [self.vm modelDataWithIndexPath:indexPath];
    [self selectedCityName:model.lists[indexPath.row]];
}

// 留给外界rac用
- (void)selectedCityName:(NSString *)cityName {
    // pop回去
    [self.navigationController popViewControllerAnimated:true];
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

@end
