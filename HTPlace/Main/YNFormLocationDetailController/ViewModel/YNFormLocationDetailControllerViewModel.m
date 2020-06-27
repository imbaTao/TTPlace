//
//  YNFormLocationDetailControllerViewModel.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormLocationDetailControllerViewModel.h"
#import <MJExtension/MJExtension.h>
//@interface YNFormLocationDetailControllerViewModel()
//
///**
// 定位到的城市
// */
//@property(nonatomic, readwrite, copy)NSString *locationCityName;
//
//@end

@implementation YNFormLocationDetailControllerViewModel

- (void)vm {
    [super vm];
    
    // 如果得到了
    self.locationCityName = @"上海";
    self.canPullUp = self.canPulldown = false;
    self.classNames = @[@"YNFormLocationDetailCell"];
    
   NSString *filePath = [[NSBundle mainBundle]pathForResource:@"CityJson" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *dataDic =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    self.data = [YNFormLocationDetailControllerModel mj_objectArrayWithKeyValuesArray:dataDic[@"city"]];
}

- (UIView *)sectionHeaderView:(NSInteger)section {
    UIView *containerView = [[UIView alloc] init];
    if (section == 0) {
        containerView.backgroundColor = rgba(244, 247, 249, 1);
        
        UILabel *titleLable = [UILabel regularFontWithSize:13 color:rgba(102, 102, 102, 1)];
        titleLable.text = @"全部";
        [containerView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(19);
            make.centerY.equalTo(containerView);
        }];
        return containerView;
    }else {
        containerView.backgroundColor = [UIColor whiteColor];
        YNFormLocationDetailControllerModel *model = self.data[section];
        UILabel *titleLable = [UILabel mediumFontWithSize:14 color:rgba(0, 0, 0, 1)];
        titleLable.text = model.title;
        [containerView addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(13);
            make.centerY.equalTo(containerView);
        }];
        return containerView;
    }
}

- (UIView *)sectionFooterView:(NSInteger)section {
    return nil;
}

- (CGFloat)sectionHeaderHeightOfRow:(NSInteger)section {
     return 42;
}

- (CGFloat)heightOfRow:(NSIndexPath *)indexPath {
    return 42;
}

- (NSInteger)itemsInSection:(NSInteger)section {
    YNFormLocationDetailControllerModel *model = self.data[section];
    return model.lists.count;
}
@end
