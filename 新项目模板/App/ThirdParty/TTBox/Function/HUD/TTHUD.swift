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
        MBProgressHUD.hide(for: rootWindow(), animated: false)
        let hud = MBProgressHUD.showAdded(to: rootWindow(), animated: true)
        hud.bezelView.style = .solidColor;
        hud.bezelView.backgroundColor = rgba(0, 0, 0, 0.5);
        hud.isUserInteractionEnabled = true;
        hud.hide(animated: true ,afterDelay: 1.5)
        hud.removeFromSuperViewOnHide = true
        return hud
    }
    
    
    func removeHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: rootWindow(), animated: false)
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

// 展示HUD
func showError(_ message: String) {
    DispatchQueue.main.async {
        let hud = HudManager.shared.creatHud()
        hud.mode = .customView;
        let imageView = UIImageView.init(image: .name("HTHudError"))
        hud.customView = imageView
        hud.label.numberOfLines = 0;
        hud.label.text = message
        hud.label.font = UIFont.regular(14)
        hud.label.textColor = .white
        hud.cornerRadius = 4
        hud.margin = hor(15)
    }
}


// 检查文本长度限制一下
func p_checkTextWidth(_ hud: MBProgressHUD, _ showView: UIView) {
    var textLabel: UILabel!
    if hud.label.text!.count > hud.detailsLabel.text!.count {
        textLabel = hud.label
    } else {
        textLabel = hud.detailsLabel
    }

    // 计算文本高
    let textWidth = textLabel.text!.size(for: textLabel.font, size: CGSize(width: SCREEN_W, height: CGFloat(MAXFLOAT)), mode: textLabel.lineBreakMode).width ?? 0.0

    // 宽度太宽了限制一下
    if textWidth > SCREEN_W * 0.6 {
        hud.width = SCREEN_W * 0.6 + (hud.margin ?? 0) * 2

        // 居中
        hud.x = (SCREEN_W - hud.width + hud.margin) * 0.5
        hud.hide(animated: true, afterDelay: 5)
    }
}




// laoding
func showLoading() {
    showLoading("")
}

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
        hud.hide(animated: true ,afterDelay: 10)

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


