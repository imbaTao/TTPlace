//
//  HomeViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"

#pragma mark - View
#import "HomeCollectionView.h"

#pragma mark - ExampleVC
#import "ShowExampleViewController.h"
#import "HZYBubbleVC.h"


#import "NSCodingLearnMethod.h"
#import <objc/runtime.h>
#import "HZYReNameView.h"
#import "MonitorFileChangeUtils.h"
#import "MonitorFileChangeUtils+one.h"
#import "HZYGCDLater.h"
@interface HomeViewController ()<HomeCollectionViewDelegate,HZYRenameViewDelegate>
/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;

/** tempView */
@property(nonatomic,strong)UIButton *tempView;

/** bubbleVC */
@property(nonatomic,strong)HZYBubbleVC *bubbleVC;

/** reNameView */
@property(nonatomic,strong)HZYReNameView *renameView;

/** fileWatherTask */
@property(nonatomic,copy)GCDTask fileWatherTask;
@end


@implementation HomeViewController{
    MonitorFileChangeUtils *watcher;
    UIImageView *imageV;
}

// 1.文件监听
// 2.图片截取
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HZYTabbarController share] showTabbar];
    
//    [self firstMethod];
   
//    [self thirdMethod];
//    [self fourthMethod];
//    [self fivethMethod];
//    [HZYGCDLater gcdTest];
    
    
    
  
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"执行了");
        if (_fileWatherTask) {
            [HZYGCDLater gcdCancel:_fileWatherTask];
        }
        _fileWatherTask = [HZYGCDLater gcdDelay:2 task:^{
            NSLog(@"oc output after 5 seconds");
        }];
//    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [timer fire];
    
}



static int count = 100000;
- (void)firstMethod{
    NSMutableArray *numberArr  = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [numberArr addObject:[NSNumber numberWithInt:i]];
    }
    
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    dispatch_queue_t  myque = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    //    dispatch_queue_t globalQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 串行队列同步执行
    dispatch_async(myque, ^{
        [numberArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSLog(@"%ld - arrayEnumerator-1",[obj integerValue]);
            if (idx == numberArr.count - 1) {
                NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
                NSLog(@"%f-time1",endTime1  - beginTime1);
                 [self secondMethod];
            }
        }];
    });
}



- (void)secondMethod{
    NSMutableArray *numberArr  = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [numberArr addObject:[NSNumber numberWithInt:i]];
    }
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    [numberArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%ld - arrayEnumerator-2",[obj integerValue]);
    }];
    NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%f-time2",endTime1  - beginTime1);
    [self thirdMethod];
}


- (void)thirdMethod{
    NSMutableArray *numberArr  = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [numberArr addObject:[NSNumber numberWithInt:i]];
    }
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    for (int i = 0; i < numberArr.count; i++) {
//        NSLog(@"%d - arrayEnumerator-3",i);
    }
    NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%f-time3",endTime1  - beginTime1);
    [self fourthMethod];
}

- (void)fourthMethod{
    NSMutableArray *numberArr  = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [numberArr addObject:[NSNumber numberWithInt:i]];
    }
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    for (NSNumber *number in numberArr) {
//        NSLog(@"%d - arrayEnumerator-4",[number intValue]);
    }
    NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"%f-time4-遍历",endTime1  - beginTime1);
    [self fivethMethod];
}


- (void)fivethMethod{
    NSMutableArray *numberArr  = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [numberArr addObject:[NSNumber numberWithInt:i]];
    }
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    dispatch_queue_t  myque = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    dispatch_async(myque, ^{
        for (NSNumber *number in numberArr) {
//            NSLog(@"%d - arrayEnumerator-5",[number intValue]);
        }
        NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
        NSLog(@"%f-time5-队列遍历",endTime1  - beginTime1);
        [self sixthMethod];
    });
}

- (void)sixthMethod{
    NSTimeInterval beginTime1 = [[NSDate date] timeIntervalSince1970];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_apply(count, queue, ^(size_t insex) {
        if (insex == count - 1) {
             NSTimeInterval endTime1 = [[NSDate date] timeIntervalSince1970];
             NSLog(@"%f-time6-disPath遍历",endTime1  - beginTime1);
        }
    });
}


- (void)forinWithArray:(NSMutableArray *)arr class:(id)class{
//    for ( in <#collection#>) {
//        <#statements#>
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configNavi];
}

- (void)layoutPageViews{
    self.homeCollectionView.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.renameView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(SCREEN_W - 120, SCREEN_H - 200, 70, 70);
    changeBtn.backgroundColor = [UIColor redColor];
    [changeBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}


#pragma mark - RenameDelgate
- (void)finishChangeFileName:(NSString *)fileName{
    if (1) {// 检测
       [_renameView hid];
    }
    NSLog(@"%@",fileName);
}

- (HZYReNameView *)renameView{
    if (!_renameView) {
        _renameView = [[NSBundle mainBundle] loadNibNamed:@"HZYReNameView" owner:nil options:nil].lastObject;
        _renameView.delegate = self;
    }
    return _renameView;
}


#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
    
//    ShowExampleViewController *vc = [[ShowExampleViewController alloc] initWithType:indexPath.row];
//    [self.navigationController pushViewController:vc animated:true];
//    _homeCollectionView.rowOrCol =  !_homeCollectionView.rowOrCol;
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:indexPath];
    if (!cell.isSelected) {
        cell.isSelected = true;
        cell.backgroundColor = [UIColor orangeColor];
    }else{
        cell.isSelected = false;
        cell.backgroundColor = [UIColor blackColor];
    }
    
//    self.bubbleVC = [[HZYBubbleVC alloc] initWithTitleArr:@[@"播放",@"重命名",@"删除"] picNameArr:@[@"Bubble_Play",@"Bubble_Rename",@"Bubble_Delete"] appointView:self.view width:SCREEN_W * 0.9 haveHeader:true];
//    [self.bubbleVC showBubbleWithVC:self];

//    for (int i = 0; i < 2; i++) {
//        NSInteger index = 5 - i;
//        NSString *string = _homeCollectionView.dataArray[index];
//        [_homeCollectionView.dataArray removeObjectAtIndex:index];
//        [_homeCollectionView.dataArray insertObject:string atIndex:0];
//        [_homeCollectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    }
////    for (NSString *string in _homeCollectionView.dataArray) {
////        NSLog(@"%@",string);
////    }
}



- (void)change{
    [self.renameView showWithSourceName:@"不啦啦啦啦啦啦是打发辣椒水的发了多少交罚款司法局啊发爱上；砥砺奋进不啦啦啦啦啦啦是打发辣椒水的发了多少交罚款司法局啊发爱上；砥砺奋进不啦啦啦啦啦啦是打发辣椒水的发了多少交罚款司法局啊发爱上；砥砺奋进不啦啦啦啦啦啦是打发辣椒水的发了多少交罚款司法局啊发爱上；砥砺奋进不啦啦啦啦啦啦是打发辣椒水的发了多少交罚款司法局啊发爱上；砥砺奋进"];
//    NSMutableArray *indexArray = [NSMutableArray array];
//    for (int i = 0; i < _homeCollectionView.dataArray.count; i++) {
//        HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (cell.isSelected) {
//            [indexArray addObject:[NSNumber numberWithInt:i]];
//        }
//    }
//
//    for (int i = 0; i < indexArray.count; i++) {
//        int index = [indexArray[i] intValue];
//        NSString *string = _homeCollectionView.dataArray[index];
//        [_homeCollectionView.dataArray removeObjectAtIndex:index];
//        [_homeCollectionView.dataArray insertObject:string atIndex:0];
//        [_homeCollectionView moveItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] toIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//    }
}


- (void)delete{
    for (int i = 0; i < _homeCollectionView.dataArray.count; i++) {
        HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.isSelected) {
            [_homeCollectionView.dataArray removeObjectAtIndex:i];
            [_homeCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
        }
    }
    // hud_wait
    
    // finish_hudHide
}


#pragma mark - Response
- (void)bublleAction{
    [self.bubbleVC showBubbleWithVC:self];
}

- (void)searchFiles:(NSMutableArray *)intvalue{
    
}

- (void)menuAction{
    
}
#pragma mark - Setter && Getter
- (HomeCollectionView *)homeCollectionView{
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 4;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCREEN_W - 60)  / 5, (SCREEN_W - 60) / 5);
        _homeCollectionView = [[HomeCollectionView alloc] initWithLayout:layout cellClass:[HomeCollectionViewCell class] identifier:@"CellID"];
        _homeCollectionView.cellDelegate = self;
    }
    return _homeCollectionView;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}


#pragma mark - private
- (void)p_configNavi{
    [self hiddenLeftBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFiles) image:[UIImage imageNamed:@"search"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuAction) image:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
