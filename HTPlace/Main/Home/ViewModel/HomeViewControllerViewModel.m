//
//  HomeViewControllerViewModel.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HomeViewControllerViewModel.h"

@implementation HomeViewControllerViewModel

- (void)vm {
    [super vm];
    self.canPullUp = self.canPulldown = false;
    self.classNames = @[@"YNFormGenderTableViewCell",@"YNFormTableViewCell"];
    
}

- (NSString *)cellIdentiyferWithIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.section == 1) {
         return self.classNames[0];
     }else {
         return [super cellIdentiyferWithIndexPath:indexPath];
     }
}

- (CGFloat)heightOfRow:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 80;
    }else {
        return 50;
    }
//    YNFormTableViewFormModel *model = [self modelDataWithIndexPath:indexPath];
//    switch (model.type) {
//        case YNFormTableViewFormModelTypeDefault:{
//
//        }break;
//
//        default:break;
//    }
}

- (CGFloat)sectionFooterHeightOfRow:(NSInteger)section {
    return 27;
}

- (UIColor *)segementLineColor {
    return [UIColor whiteColor];
}

@end
