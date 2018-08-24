//
//  DiscoverTableViewCell.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/5.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import "DisCoverGuideCell.h"
#import "BaseTableView.h"

#pragma mark - CELL

@interface DiscoverTableViewCell()<UITableViewDelegate,UITableViewDataSource>


/** subTableView */
@property(nonatomic,strong)BaseTableView *subTableView;
@end

@implementation DiscoverTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backGroundImgView];
        [self.backGroundImgView addSubview:self.subTableView];
        [self.backGroundImgView addSubview:self.guideImgView];
        [self layoutPageViews];
        _subTableView.dataArray = [NSMutableArray arrayWithObjects:@"1111111",@"22222222",@"33333333",@"4444444",nil];
        [_subTableView reloadData];
    }
    return self;
}


- (void)layoutPageViews{
    [self.backGroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.subTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(left(21));
        make.top.offset(top(23.25));
        make.bottom.offset(bottom(10.5));
        make.width.equalTo(self.mas_width).multipliedBy(0.566);
    }];
    
    [self.guideImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.offset(-right(15));
        make.width.mas_equalTo(self.guideImgView.mas_height);
        make.height.offset(SCREEN_W * 0.3867);
    }];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"2");
    DisCoverGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:self.subTableView.cellID];
    cell.titleLB.text = [NSString stringWithFormat:@"%ld.%@",indexPath.row + 1,self.subTableView.dataArray[indexPath.row]];
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subTableView.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - Setter && Getter
- (BaseTableView *)subTableView{
    if (!_subTableView) {
        _subTableView = [[BaseTableView alloc] initWithCellClass:[DisCoverGuideCell class] identifier:@"GuideCell" style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.backgroundColor = [UIColor clearColor];
        _subTableView.userInteractionEnabled = false;
    }
    return _subTableView;
}

- (UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
        _backGroundImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _backGroundImgView;
}

- (UIImageView *)guideImgView{
    if (!_guideImgView) {
        _guideImgView = [[UIImageView alloc] init];
    }
    return _guideImgView;
}
@end
