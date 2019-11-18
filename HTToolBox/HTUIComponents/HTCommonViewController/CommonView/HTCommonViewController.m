//
//  HTCommonViewController.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/27.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonViewController.h"

@interface HTCommonViewController ()
/**
 vm
 */
@property(nonatomic, readwrite, strong)HTCommonViewModel *vm;

@end

@implementation HTCommonViewController

- (instancetype)initWithViewModel:(HTCommonViewModel *)vm
{
    self = [super init];
    if (self) {
        self.vm = vm;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
