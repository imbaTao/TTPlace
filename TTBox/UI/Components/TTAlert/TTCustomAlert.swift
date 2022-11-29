//
//  TTCustomAlert.swift
//  TTNew
//
//  Created by Mr.hong on 2022/3/9.
//

import Foundation

// 点击隐藏视图
class TTCustomAlert: UIControl {

    @discardableResult
    class func show(
        customView: UIView, touchHidden: Bool = false, backGroundColor: UIColor = rgba(0, 0, 0, 0.5)
    ) -> TTCustomAlert {
        let alert = TTCustomAlert()
        alert.backgroundColor = backGroundColor
        alert.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        rootWindow().addSubview(alert)
        alert.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        if touchHidden {
            // config
            alert.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak alert] (_) in
                // 点击隐藏
                alert?.isHidden = true
                alert?.removeSubviews()
                alert?.removeFromSuperview()
            }).disposed(by: alert.rx.disposeBag)
        }

        return alert
    }

    // 移除window上Alert
    class func dismiss() {
        for view in rootWindow().subviews {
            if view.isKind(of: TTCustomAlert.self) {
                view.removeFromSuperview()
            }
        }
    }
}

// 全局显示原生的弹框
func showOriginalAlert(
    title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert,
    buttonTitles: [String] = ["确定", "取消"], click: @escaping (_ index: Int) -> Void
) {

    DispatchQueue.main.async {
        let alertVC = UIAlertController.init(
            title: title, message: message, preferredStyle: preferredStyle)

        // 创建action
        for index in 0..<buttonTitles.count {
            // 标题
            let title = buttonTitles[index]

            var style = UIAlertAction.Style.default

            if title.contains("取消") {
                style = UIAlertAction.Style.cancel
            }

            let action = UIAlertAction.init(title: title, style: style) { (action) in
                click(index)
            }

            alertVC.addAction(action)
        }

        // 显示
        rootWindow().rootViewController?.present(
            alertVC, animated: true,
            completion: {

            })
    }
}

class TTBomttomAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.portraitAnimateStyle = .bottom
    }
}

class TTFreeAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.portraitAnimateStyle = .free
    }
}

class TTCenterAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.portraitAnimateStyle = .center
    }
}

class TTRightToLeftAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.portraitAnimateStyle = .rightToLeft
    }
}

class TTLeftToRightAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.portraitAnimateStyle = .leftToRight
    }
}

//class  TTRotateAlert: TTAlert {
////    override func bindViewModel() {
////        super.bindViewModel()
////
////
////    }
//
//    init(landStyle: TTAlertAnimateStyle,portraitStyle: TTAlertAnimateStyle,_ configBlock: ((TTAlertConfig) -> Void)? = nil) {
//        super.init { config in
//
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func setupConfig() {
//        super.setupConfig()
//        config.touchHidden = true
//
//
//
//
//        config.showAnimateStyle = .leftToRight
//    }
//}
