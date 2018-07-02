//
//  PersonalTableView.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "PersonalTableView.h"
@implementation PersonalTableView

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    cell.leftTitleLB.text = @"XXXXXXX";
    return cell;
}

@end



#pragma mark - CELL
@implementation PersonalTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.leftTitleLB];
        [self addSubview:self.rightArrowImgView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.leftTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(12).priorityHigh();
        make.right.mas_equalTo(self.rightArrowImgView.mas_right).offset(-12);
    }];
    
    [self.rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.offset(-12);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

#pragma mark - Setter && Getter
- (UILabel *)leftTitleLB{
    if (!_leftTitleLB) {
        _leftTitleLB = [UILabel creatLabelWithText:@"xxxx" textColor:[UIColor whiteColor] fontSize:14];
        _leftTitleLB.backgroundColor = [UIColor clearColor];
        _leftTitleLB.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTitleLB;
}

- (UIImageView *)rightArrowImgView{
    if (!_rightArrowImgView) {
        _rightArrowImgView = [[UIImageView alloc] init];
        _rightArrowImgView.image = [UIImage imageNamed:@"nav_rightArrow"];
    }
    return _rightArrowImgView;
}

@end


