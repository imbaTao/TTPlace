//
//  PersonalTableView.m
//  HTToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "PersonalTableView.h"
@implementation PersonalTableView

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    cell.leftTitleLB.text = [NSString stringWithFormat:@"%ld.%@",indexPath.section + 1,self.dataArray[indexPath.section]];
    cell.rightImgView.image = [UIImage imageNamed:@"nav_rightArrow"];
    return cell;
}


//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;//section头部高度
}

//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W,15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end



#pragma mark - CELL

@interface PersonalTableViewCell ()
/** backBoardView */
@property(nonatomic,strong)UIView *backBoardView;

@end
@implementation PersonalTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backBoardView];
        [self addSubview:self.leftTitleLB];
        [self addSubview:self.rightImgView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.backBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 4, 0));
    }];

    [self.leftTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(12).priorityHigh();
        make.right.mas_equalTo(self.rightImgView.mas_right).offset(-12);
    }];

    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.offset(-12);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}

#pragma mark - Setter && Getter
- (UIView *)backBoardView{
    if (!_backBoardView) {
        _backBoardView = [[UIView alloc] init];
        _backBoardView.backgroundColor = RGB(57, 57, 57);;
        _backBoardView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backBoardView.layer.shadowOpacity = 0.8;
        _backBoardView.layer.shadowOffset = CGSizeMake(0, 4);
    }
    return _backBoardView;
}
- (UILabel *)leftTitleLB{
    if (!_leftTitleLB) {
//        _leftTitleLB = [UILabel creatLabelWithText:@"xxxx" textColor:[UIColor whiteColor] fontSize:14];
//        _leftTitleLB.backgroundColor = [UIColor clearColor];
//        _leftTitleLB.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTitleLB;
}

- (UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
    }
    return _rightImgView;
}

@end


