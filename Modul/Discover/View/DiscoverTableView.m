//
//  DiscoverTableView.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "DiscoverTableView.h"
@implementation DiscoverTableView

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    cell.backGroundImgView.image = [UIImage imageNamed:@"discover_test"];
    return cell;
}
@end



#pragma mark - CELL
@implementation DiscoverTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backGroundImgView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.backGroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
    }
    return _backGroundImgView;
}
@end


