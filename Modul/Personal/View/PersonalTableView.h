//
//  PersonalTableView.h
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseTableView.h"
@interface PersonalTableView : BaseTableView
@end

@interface PersonalTableViewCell: UITableViewCell
/** leftTitleLB */
@property(nonatomic,strong)UILabel *leftTitleLB;
/** rightArrowImgView */
@property(nonatomic,strong)UIImageView *rightArrowImgView;
@end
