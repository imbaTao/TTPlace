////
////  HomeViewController.m
////  TTPlace
////
////  Created by Mr.hong on 2020/9/8.
////  Copyright © 2020 Mr.hong. All rights reserved.
////
//
//#import "HomeViewController.h"
//#import "HomeViewController2.h"
//
//
//@interface HomeViewControllerVM: TTCommonTableViewModel
//
//@end
//
//@implementation  HomeViewControllerVM
//- (void)vm {
//    self.data =  [@[@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123"] mutableCopy];
//}
//
//- (NSArray *)classNames {
//    return @[@"UITableViewCell"];
//}
//
//
//- (CGFloat)heightOfRow:(NSIndexPath *)indexPath {
//    return 100;
//}
//
//@end
//
//@interface HomeViewController ()
///**
// vm
// */
//@property(nonatomic, readwrite, strong)HomeViewControllerVM *vm;
//
//
//
///**
// 进度条
// */
//@property(nonatomic, readwrite, strong)UIView  *progessView;
//
//@end
//
//@implementation HomeViewController
//
//@synthesize vm = _vm;
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _vm = [[HomeViewControllerVM alloc] init];
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.offset(0);
//        make.height.offset(350);
//    }];
//    
//    self.progessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 300)];
//    self.tableView.tableHeaderView = self.progessView;
//    // Do any additional setup after loading the view.
//    self.title = @"我是第一页";
//    
////    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 400, 400, 300)];
////    self.tempLabel.backgroundColor = [UIColor redColor];
////    self.tempLabel.text = @"我是第一页";
////    [self.view addSubview:self.tempLabel];
//    
//
//#if DEBUG
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
//    });
//#endif
//}
//
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
//    cell.textLabel.text = @"123123";
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//  
//    TTLoading;
//    
//    NSLog(@"点击到了屏幕！！！！！！！！！");
//    
//    
////    if (self.tableView.tableHeaderView.height == 0) {
////        [self.tableView beginUpdates];
////              [UIView animateWithDuration:0.3 animations:^{
////                  self.progessView.height = 300;
////              }];
////        [self.tableView endUpdates];
////    }else {
////
////     // 使用动画修改headerView高度
////        [self.tableView beginUpdates];
////        [UIView animateWithDuration:0.3 animations:^{
////            self.progessView.height = 0;
////        }];
////        [self.tableView endUpdates];
////
//////        [self.view layoutIfNeeded];
////    }
//}
//
////- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////      HomeViewController2 *vc2 = [[HomeViewController2 alloc] init];
////
////     //在push动画之前设置动画代理
////     self.navigationController.delegate = vc2;
////     [self.navigationController pushViewController:vc2 animated:YES];
////}
//
//
//// 热刷新UI代码，不用可以注释掉，不调用
//- (void)hotReload {
//    [self removeAllViews:self.view];
//    [self viewDidLoad];
//}
//
//// 热刷新UI代码，不用可以注释掉，不调用
//- (void)removeAllViews:(UIView *)view {
//    while (view.subviews.count) {
//        UIView* child = view.subviews.lastObject;
//        [child removeFromSuperview];
//    }
//}
//
//
//@end
