//
//  ShowExampleViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "ShowExampleViewController.h"
#import "GCDWebUploader.h"
#import "SJXCSMIPHelper.h"
#import <Photos/Photos.h>
@interface ShowExampleViewController()<GCDWebUploaderDelegate>
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
        case demo_TakePhotoOrVideos:[self demo_takePhotoOrVideos];break;
        default:break;
    }
}

#pragma mark - PhotoOrVideos
- (void)demo_takePhotoOrVideos{
    // 检测权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            //code
        }
    }];
    
    
    
//     列出所有相册智能相册
        PHFetchOptions *fetchResoultOption = [[PHFetchOptions alloc] init];
        fetchResoultOption.includeHiddenAssets = false;
        fetchResoultOption.includeAllBurstAssets = false;
    
        PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumVideos options:fetchResoultOption];
         [PHCollection fetchTopLevelUserCollectionsWithOptions:fetchResoultOption];
    
        [smartAlbums enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[PHAssetCollection class]]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)obj;
                NSLog(@"%@", assetCollection.localizedTitle);
                if ([assetCollection canPerformEditOperation:PHCollectionEditOperationDeleteContent]) {
    //             PHImageManager
                    
                    
                    
                }
            }
        }];
        NSLog(@"smartAlbums.count：%ld", smartAlbums.count);

}














#pragma mark - WifiTransfer
- (void)demo_wifiTransfer{
    // 文件存储位置
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"文件存储位置 : %@", documentsPath);
    
    // 创建webServer，设置根目录
   GCDWebUploader *_webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    // 设置代理
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    
    // 限制文件上传类型
    _webServer.allowedFileExtensions = @[@"doc", @"docx", @"xls", @"xlsx", @"txt", @"pdf"];
    // 设置网页标题
    _webServer.title = @"兔·小白的demo";
    // 设置展示在网页上的文字(开场白)
    _webServer.prologue = @"欢迎使用兔·小白的WIFI管理平台";
    // 设置展示在网页上的文字(收场白)
    _webServer.epilogue = @"兔·小白制作";
     UILabel *showIpLabel = [[UILabel alloc] init];
    [self.view addSubview:showIpLabel];
    [showIpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    if ([_webServer start]) {
        showIpLabel.hidden = NO;
        showIpLabel.text = [NSString stringWithFormat:@"请在网页输入这个地址  http://%@:%zd/", [SJXCSMIPHelper deviceIPAdress], _webServer.port];
    } else {
        showIpLabel.text = NSLocalizedString(@"GCDWebServer not running!", nil);
    }
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
