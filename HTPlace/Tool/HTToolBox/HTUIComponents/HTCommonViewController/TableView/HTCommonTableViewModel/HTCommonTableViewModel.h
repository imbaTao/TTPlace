//
//  HTCommonTableViewModel.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonViewModel.h"

// 整型转字符串
#define INTTOSTRING(num) [NSString stringWithFormat:@"%zi",num]

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewModel : HTCommonViewModel

/**
 数据源
 */
@property (nonatomic, readwrite, strong)NSArray *data;

/**
 数据源2，主要用来上下拉数据中转用的，平时用不到
 */
@property(nonatomic, readwrite, copy)NSArray *data2;

/**
 风格
 */
@property (nonatomic, readwrite, assign) UITableViewStyle style;

/**
 是否能下拉
 */
@property (nonatomic, readwrite, assign) BOOL canPulldown;

/**
 是否能上拉拉
 */
@property (nonatomic, readwrite, assign) BOOL canPullUp;

/**
 是否自动开始第一次刷新
 */
@property (nonatomic, readwrite, assign) BOOL autoFirstRefresh;

/**
 当前页 defalut is 1
 */
@property (nonatomic, readwrite, assign) NSInteger page;

/**
 页码数默认是10
 */
@property (nonatomic, readwrite, assign) NSInteger pageSize;

/**
 选中命令
 */
@property (nonatomic, readwrite, strong) RACCommand *didSelectCommand;

/**
 反选中命令
 */
@property (nonatomic, readwrite, strong) RACCommand *didDeselectCommand;

/**
 请求数据源
 */
@property (nonatomic, readwrite, strong) RACCommand *fetchDataSourceCommand;

/**
 刷新信号
 */
@property(nonatomic, readwrite, strong)RACSubject *refreshSubject;

/**
 内容边距
 */
@property(nonatomic, readwrite, assign)UIEdgeInsets contentInset;

/**
 注册cell的类别种类
 */
@property(nonatomic, readwrite, copy)NSArray *classNames;

/**
 空数据展示页的icon地址
 */
@property(nonatomic, readwrite, copy)NSString *emptyIconPath;

/**
 空数据提示文字
 */
@property(nonatomic, readwrite, copy)NSString *emtyTips;





/**
 根据下标获取模型数据
 */
- (id)modelDataWithIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 代理类方法

/**
 返回组数
 */
- (NSInteger)numberOfSections;

/**
 每组多少个
 */
- (NSInteger)itemsInSection:(NSInteger)section;

/**
 返回cell高度
 */
- (CGFloat)heightOfRow:(NSIndexPath *)indexPath;

/**
 返回sectionHeader高度
 */
- (CGFloat)sectionHeaderHeightOfRow:(NSInteger)section;

/**
 返回sectionheaderView
 */
- (UIView *)sectionHeaderView:(NSInteger)section;

/**
 返回sectionFooter高度
 */
- (CGFloat)sectionFooterHeightOfRow:(NSInteger)section;

/**
 返回sectionheaderView
 */
- (UIView *)sectionFooterView:(NSInteger)section;

/**
 分割线颜色
 */
- (UIColor *)segementLineColor;

/**
 分割线两端的间距
 */
- (CGFloat)segementInterval;

/**
 通知刷新
 */
- (void)reloadData;

/**
 根据页码获取数据
 */
- (RACSignal *)fetchDataWithPage:(NSInteger)page;

/**
 根据下标返回Cell的ID
 */
- (NSString *)cellIdentiyferWithIndexPath:(NSIndexPath *)indexPath;



/// 占位empty类型
//@property (nonatomic, readwrite, assign) SBDefaultEmptyBackgroundType emptyType;
/// 网络不可用 default is NO
//@property (nonatomic, readwrite, assign) BOOL disableNetwork;

/** fetch the local data */
//- (id)fetchLocalData;

///// 请求错误信息过滤
//- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter;
//
///// 当前页之前的所有数据
//- (NSUInteger)offsetForPage:(NSUInteger)page;
//
///** request remote data or local data, sub class can override it
// *  page - 请求第几页的数据
// */
//- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end

NS_ASSUME_NONNULL_END
