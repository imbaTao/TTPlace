//
//  TTHUD.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/22.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import UIKit



class HudManager {
    static let shared = HudManager()
    
    //    #define HUDCircleWidth 84
    //    #define HUDDefaultShowTime 1.2
    //    #define HUDDefaultShowLongTime 2.0
    let HUDCircleWidth: CGFloat = 32
    var showWindow: UIWindow {
        // 倒叙 遍历
        for tWindow in UIApplication.shared.windows.reversed() {
            if TTKeyboardManager.shared.isKeyboardShowing.value,let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),tWindow.isKind(of: keyboardWindowClass) {
                // 优先显示键盘window上
                return tWindow
            }
            
            // 找到满足条件的window
            if tWindow.isHidden == false,let effName = NSClassFromString("UITextEffectsWindow"),tWindow.isKind(of: effName) == false {
                return tWindow
            }
        }
        
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow
        }
        
        return (UIApplication.shared.delegate!.window!!)
    }

    // 获取一个hud
    func creatHud() -> MBProgressHUD {
        // 创建前先移除上一个
        removeHud()

        // 创建前先移除上一个
        let hud = MBProgressHUD.showAdded(to: showWindow, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = rgba(0, 0, 0, 0.5)
        hud.isUserInteractionEnabled = false
        hud.hide(animated: true, afterDelay: 1.5)
        hud.removeFromSuperViewOnHide = true
        hud.minSize = .init(width: HUDCircleWidth, height: HUDCircleWidth)
        return hud
    }

    func removeHud() {
        // 创建前先移除上一个
        for window in UIApplication.shared.windows {
            for subView in window.subviews {
                if subView.isKind(of: MBProgressHUD.self) {
                    let hud = subView as! MBProgressHUD
                    hud.hide(animated: false)
                }
            }
        }
    }
}

// 展示HUD
func showHUD(_ message: String?) {
    DispatchQueue.main.async {
        let hud = HudManager.shared.creatHud()
        hud.mode = .text
        hud.label.numberOfLines = 0
        hud.label.text = message
        hud.label.font = UIFont.regular(14)
        hud.label.textColor = .white
        hud.cornerRadius = 4
        hud.margin = hor(15)
    }
}

// 展示HUD
func showError(_ message: String?) {
    DispatchQueue.main.async {
        let hud = HudManager.shared.creatHud()
        hud.mode = .customView
        let imageView = UIImageView.init(image: .name("HTHudError"))
        hud.customView = imageView
        hud.label.numberOfLines = 0
        hud.label.text = message ?? ""
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
    //    let textWidth = textLabel.text!.size(for: textLabel.font, size: CGSize(width: SCREEN_W, height: CGFloat(MAXFLOAT)), mode: textLabel.lineBreakMode).width ?? 0.0

    let textWidth = 0

    //    // 宽度太宽了限制一下
    //    if textWidth > SCREEN_W * 0.6 {
    //        hud.width = SCREEN_W * 0.6 + (hud.margin ?? 0) * 2
    //
    //        // 居中
    //        hud.x = (SCREEN_W - hud.width + hud.margin) * 0.5
    //        hud.hide(animated: true, afterDelay: 5)
    //    }
}

// laoding
func showLoading() {
    showLoading("")
}

func showLoading(duration: Int = 2) {
    showLoading("", duration, true, nil)
}

/// isPenetrate 是否点击事件可穿透
func showLoading(
    _ message: String = "", _ duradion: Int = 10, _ isPenetrate: Bool = true,
    _ addView: UIView? = nil
) {
    DispatchQueue.main.async {
        // 创建前先移除上一个
        HudManager.shared.removeHud()

        var showView: UIView!
        if let addView = addView {
            showView = addView
        } else {
            showView = HudManager.shared.showWindow
        }

        // 创建前先移除上一个
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = rgba(0, 0, 0, 0.5)
        hud.hide(animated: true, afterDelay: 1.5)
        hud.removeFromSuperViewOnHide = true
        //        hud.minSize = .init(width: HUDCircleWidth, height: HUDCircleWidth)

        let circleView = TTSVIndefiniteAnimatedView.init()
        circleView.frame = .init(x: 0, y: 0, width: 50, height: 50)
        circleView.radius = 18
        circleView.strokeThickness = 2
        circleView.strokeColor = UIColor.white
        hud.mode = .customView
        hud.isUserInteractionEnabled = !isPenetrate

        //
        //        let imgV = UIImageView.init(frame: .init(x: 0, y: 20, width: HudManager.shared.HUDCircleWidth, height: 50))
        //        imgV.backgroundColor = .black
        //        imgV.addSubview(circleView)

        hud.customView = circleView

        if message.isNotEmpty {
            hud.detailsLabel.numberOfLines = 0
            hud.detailsLabel.text = message
            hud.detailsLabel.font = UIFont.regular(14)
            hud.detailsLabel.textColor = .white
        }

        //        hud.label.text = "hhhhhhhhh"
        //        hud.detailsLabel.text = "123313123"

        //        hud.label.numberOfLines = 0;
        //        hud.label.text = message
        //        hud.label.font = UIFont.regular(14)
        //        hud.label.textColor = .white
        //        hud.cornerRadius = 4
        //        hud.margin = hor(15)

        hud.hide(animated: true, afterDelay: TimeInterval(duradion))
    }
}

func hiddenHUD() {
    HudManager.shared.removeHud()
}

func hiddenHUD(view: UIView?) {
    guard let view = view else { return }
    
    DispatchQueue.main.async {
        for subView in view.subviews {
            if subView.isKind(of: MBProgressHUD.self) {
                let hud = subView as! MBProgressHUD
                hud.hide(animated: false)
            }
        }
    }
}

extension MBProgressHUD {

}

extension UIImageView {
    //  设置网络图片
    //    func avatarNetImage(_ user: USER,placeholder: String = "") {
    //        if user != nil {
    //            if (user!.profile.avatar?.url.count)! > 0 {
    //                kf.setImage(with: URL(string: user!.profile.avatar?.url),placeholder: R.image.blindDate_placeHoder_avatar())
    //            }
    //        }
    //    }

}
