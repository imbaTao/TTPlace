//
//  HomeViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"
#import "HTElevatorBoard.h"

@interface TestView: UIView
/**
  button
 */
@property(nonatomic, readwrite, strong)UIButton *button;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton creatByTitle:@"我是按钮" titleColor:UIColor.whiteColor fontSize:22];
        self.backgroundColor = [UIColor whiteColor];
        self.button.backgroundColor = [UIColor blackColor];
        @weakify(self);
        [self setupLayout:^{
            @strongify(self);
            [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.offset(10);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }];
    }
    return self;
}

@end

@interface HomeViewController ()
/**
 test
 */
@property(nonatomic, readwrite, strong)TestView *testView;

@end



@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
//    self.navigationController.navigationBar.translucent = false;

 
    
//
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
}

- (void)hotReload {
    self.view.backgroundColor = [UIColor grayColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    HTElevatorBoard <TestView *> *elevatorView = [[HTElevatorBoard alloc] initWithSize:CGSizeMake(SCREEN_W, 300) vClass:TestView.class];
    [self.view addSubview:elevatorView];
    [elevatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [elevatorView showBoard];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSString *cellContent = [self.vm modelDataWithIndexPath:indexPath];
    cell.textLabel.text = cellContent;
}




#pragma mark - private
- (void)p_configNavi{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
