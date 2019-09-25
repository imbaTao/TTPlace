//
//  HTCommonTableViewModel.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTBaseCommonViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewModel : HTBaseCommonViewModel

/**
 数据源
 */
@property (nonatomic, readwrite, copy) NSMutableArray *dataSource;

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
 当前页 defalut is 1
 */
@property (nonatomic, readwrite, assign) NSUInteger page;

/**
 页码数默认是10
 */
@property (nonatomic, readwrite, assign) NSUInteger pageSize;

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
 通知刷新
 */
- (void)reloadData;

/**
 根据页码获取数据
 */
- (RACSignal *)fetchDataWithPage:(NSUInteger)page;

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
