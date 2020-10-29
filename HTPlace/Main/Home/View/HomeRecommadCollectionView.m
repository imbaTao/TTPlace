////
////  HomeRecommadCollectionView.m
////  HTPlace
////
////  Created by hong on 2020/4/22.
////  Copyright © 2020 Mr.hong. All rights reserved.
////
//
//#import "HomeRecommadCollectionView.h"
//#import "UIColor+HTColorExtentsion.h"
//
//@interface HomeRecommadCollectionView()
//@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
//@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
//@end
//
//@implementation HomeRecommadCollectionView
//- (void)dealloc
//{
//    self.scrollCallback = nil;
//}
//
//
//- (NSInteger)numberOfItemsInSection:(NSInteger)section {
//    return self.data.count;
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    HTCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTCommonCollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor randomColor];
//
//    return cell;
//}
//
//
//- (void)listViewLoadDataIfNeeded {
//
//}
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    !self.scrollCallback?:self.scrollCallback(scrollView);
//}
//
//
//#pragma mark - JXPagingViewListViewDelegate
//- (UIScrollView *)listScrollView {
//    return self;
//}
//
//- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
//    self.scrollCallback = callback;
//}
//
//
//@end
