//
//  TTHUD.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/22.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation



class HudManager {
    static let shared = HudManager()
    // 获取一个hud
    func creatHud() -> MBProgressHUD  {
        // 创建前先移除上一个
        let hud = MBProgressHUD.showAdded(to: rootWindow(), animated: true)
        hud.bezelView.style = .solidColor;
        hud.bezelView.backgroundColor = rgba(0, 0, 0, 0.5);
        hud.isUserInteractionEnabled = true;
        hud.hide(animated: true ,afterDelay: 2)
        hud.removeFromSuperViewOnHide = true
        return hud
    }
    
    
    func removeHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: rootWindow(), animated: true)
        }
        
    }
}


// 展示HUD
func showHUD(_ message: String) {
    DispatchQueue.main.async {
        let hud = HudManager.shared.creatHud()
        hud.mode = .text;
        hud.label.numberOfLines = 0;
        hud.label.text = message
        hud.label.font = UIFont.regular(14)
        hud.label.textColor = .white
        hud.cornerRadius = 4
        hud.margin = hor(15)
    }
}

// laoding
func showLoading(_ message: String) {
    DispatchQueue.main.async {
        let hud = HudManager.shared.creatHud()
        hud.mode = .indeterminate;
        hud.label.numberOfLines = 0;
        hud.label.text = message
        hud.label.font = UIFont.regular(14)
        hud.label.textColor = .white
        hud.cornerRadius = 4
        hud.margin = hor(15)
//        hud.minShowTime = 1000
    }
}


func hiddenHUD() {
    HudManager.shared.removeHud()
}



extension MBProgressHUD {
    
}



extension UIImageView {
    //  设置网络图片
//    func avatarNetImage(_ user: User?,placeholder: String = "") {
//        if user != nil {
//            if (user!.profile.avatar?.url.count)! > 0 {
//                kf.setImage(with: URL(string: user!.profile.avatar?.url),placeholder: R.image.blindDate_placeHoder_avatar())
//            }
//        }
//    }
    
}


