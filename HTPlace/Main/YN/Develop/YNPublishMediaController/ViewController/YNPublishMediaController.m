//
//  YNPublishMediaController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/7/4.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNPublishMediaController.h"
#import "YNPublishMediaControllerViewModel.h"
@interface YNPublishMediaController ()



/**
 viewMdoel
 */
@property(nonatomic, readwrite, strong)YNPublishMediaControllerViewModel *vm;

@end

@implementation YNPublishMediaController {
    TZImageManager *manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 图片管理员
    manager = [TZImageManager manager];
    
    if (![manager authorizationStatusAuthorized]) {
        [manager requestAuthorizationWithCompletion:^{
             [self fetchPhotos];
        }];
    }else {
        [self fetchPhotos];
    }
}

- (void)fetchPhotos {
    __block NSMutableArray *mutabelArray = [NSMutableArray array];
    
        
    [[TZImageManager manager] getCameraRollAlbum:false allowPickingImage:true needFetchAssets:YES completion:^(TZAlbumModel *model1) {
        
        
        NSArray *data = [NSArray arrayWithArray:model1.models];
        
        
        TZAssetModel *model = data.firstObject;
        
    
        
        
        int32_t imageRequestID = [[TZImageManager manager] getPhotoWithAsset:model.asset photoWidth:300 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            
            NSLog(@"完成");
//            // Set the cell's thumbnail image if it's still showing the same asset.
//            if ([self.representedAssetIdentifier isEqualToString:model.asset.localIdentifier]) {
//                self.imageView.image = photo;
//            } else {
//                // NSLog(@"this cell is showing other asset");
//                [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
//            }
//            if (!isDegraded) {
//                [self hideProgressView];
//                self.imageRequestID = 0;
//            }
        } progressHandler:nil networkAccessAllowed:NO];
        
//        self->_model = model;
//        self->_models = [NSMutableArray arrayWithArray:self->_model.models];
//        [self initSubviews];
    }];
    
    
}


@end
