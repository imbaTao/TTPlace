//
//  ShowExampleViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "ShowExampleViewController.h"
#import "HZYWaterFallCollectionView.h"
@interface ShowExampleViewController()<UIDocumentInteractionControllerDelegate>
/** documentVC */
@property(nonatomic,strong)UIDocumentInteractionController *documentVC;
@end

@implementation ShowExampleViewController

- (instancetype)initWithType:(DemoType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    switch (self.type) {
        case DEMO_UIView:[self demo_UIView];break;
        case DEMO_Button:[self demo_Button];break;
        case DEMO_WifiTransfer:[self demo_wifiTransfer];break;
        case DEMO_Share:[self demo_share];break;
        case DEMO_WaterFall:[self demo_waterFall];break;
        default:break;
    }
    [[HZYTabbarController share] hiddeTabbar];
}


- (void)demo_waterFall{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    HZYWaterFallCollectionView *waterWallCV =  [[HZYWaterFallCollectionView alloc] initWithLayout:layout cellClass:[UICollectionViewCell class] identifier:@"waterFallCell"];
    NSMutableArray *modelArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        HZYWaterFallModel *sizeModel = [[HZYWaterFallModel alloc] init];
        sizeModel.direction = arc4random() % 2;
        [modelArr addObject:sizeModel];
    }
    waterWallCV.dataArray = modelArr;
    [self.view addSubview:waterWallCV];
    [waterWallCV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0,0));
    }];
}


- (void)demo_share{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    
    
    // 分享面板
    NSURL *tempUrl = [NSURL fileURLWithPath:doc];
    _documentVC = [UIDocumentInteractionController interactionControllerWithURL:tempUrl];
    _documentVC.delegate = self;
//    _documentVC.UTI = @"c";
    [_documentVC presentOpenInMenuFromRect:CGRectZero inView:self.view animated:true];
}


#pragma mark - UIDocumentDelegate 备份功能代理
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

-(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}

-(CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    return self.view.frame;
}

#pragma mark - WifiTransfer
- (void)demo_wifiTransfer{
    
}




#pragma mark - UIButton
- (void)demo_Button{
    // 创建不同样式的Button
    UIButton *normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [normalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    normalButton.backgroundColor = [UIColor redColor];
    normalButton.titleLabel.backgroundColor = [UIColor greenColor];
    normalButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [normalButton setImage:[UIImage imageNamed:@"Discover_selected"] forState:UIControlStateNormal];
    [normalButton setTitle:@"测试标题" forState:UIControlStateNormal];
    [self.view addSubview:normalButton];
    [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    normalButton.titleEdgeInsets = UIEdgeInsetsMake(0, -normalButton.imageView.bounds.size.width, -(normalButton.imageView.bounds.size.width + normalButton.titleLabel.intrinsicContentSize.height), 0);
    
    // button图片的偏移量
    normalButton.imageEdgeInsets = UIEdgeInsetsMake(0, normalButton.imageView.bounds.size.width / 2, 0, 0);
    
    
    //    normalB
    // 创建标题在下的button
    
}






















#pragma mark - UIView
- (void)demo_UIView{
    UIView *normalDemoView = [[UIView alloc] init];
    normalDemoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:normalDemoView];
    [normalDemoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200 , 200));
    }];
    
    // 圆角
    normalDemoView.layer.cornerRadius = 8.0;
    //    normalDemoView.layer.masksToBounds = true;
    
    //    // ios 11出来的指定倒哪个圆角
    //    if(@available(iOS 11.0, *)) {
    //      normalDemoView.layer.maskedCorners =   kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    //    }
    
    
    //    // 阴影(倒圆角后无法显示)
    normalDemoView.layer.shadowColor = [UIColor blackColor].CGColor;
    normalDemoView.layer.shadowRadius = 4.0f;
    normalDemoView.layer.shadowOpacity = 1;
    // 纵轴Y轴偏4个pt
    normalDemoView.layer.shadowOffset = CGSizeMake(2, 4);
}


@end
