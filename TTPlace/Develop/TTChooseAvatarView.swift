//
//  TTChooseAvatarView.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/11.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation





/**
 权限检测，相机、相册，拒绝后alert处理，跳转处理
 */






// 点击按钮，弹起，选择头像
class TTChooseAvatarView: UIImageView {
    // 本身只是一个ImageView，可点击触发事件
    
    // 选择完毕后图片传出去的回调
    let chooseAvatarComplete = PublishSubject<UIImage>()
    
    // 临时的选中的头像
    private var choosedAvatar = UIImage()
    
    // 上传事件完成
    var uploadComplte: Bool = false {
        didSet {
            if uploadComplte {
                self.image = choosedAvatar
            }
        }
    }
    
    
    
    var testBlock: ((UIImage) -> (Bool))?
    
     init() {
        super.init(frame: .zero)
        
        // UI
        self.contentMode = .scaleAspectFill
        circle()
        
        
       // 点击事件
        rx.tap().subscribe(onNext: {[weak self]  in
            // 选择编辑头像
            if let parrentVC = self?.parentViewController {
                TTPhotoManager.chooseAvatar(parentVC: parrentVC).subscribe {[weak self]  (image) in
                    self?.choosedAvatar = image
                    
                    // 解析头像
                    self?.chooseAvatarComplete.onNext(image)
                    
                    // 需要传进来一个方法来上传image，并告诉我当前的结果
//                    self.method(image).subs
                    self?.testBlock?(image)

                } onError: { (error) in
                   if let error = error as? TTPhotoManagerError {
                        switch error.type {
                        case -1:
                            showHUD("没有获取图片权限")
                        default:
                            break
                        }
                    }
                }.disposed(by: self?.rx.disposeBag ?? DisposeBag())
            }
        }).disposed(by: rx.disposeBag)
    }
    
    
    deinit {
        print("释放了")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
