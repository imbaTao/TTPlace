//
//  TTPanActionHelper.swift
//  hdd4iPhone
//
//  Created by Mr.hong on 2021/12/7.
//  Copyright © 2022 Q. All rights reserved.
//

import Foundation

// 手势对象
class TTPanActionHelper: NSObject {
    var visibleBounds: CGRect!
    weak var panSuperView: UIView?
    weak var panView: UIView?

    lazy var pan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        return pan
    }()
    init(panSuperView: UIView, panView: UIView, visibleBounds: CGRect) {
        self.visibleBounds = visibleBounds
        self.panSuperView = panSuperView
        self.panView = panView
        super.init()
        panView.addGestureRecognizer(pan)
    }

    @objc func panAction(_ panGes: UIPanGestureRecognizer) {
        guard let panView = panView else {
            return
        }
        let point = panGes.location(in: panSuperView)

        var moveX = point.x
        if moveX < visibleBounds.origin.x + panView.size.width * 0.5 {
            moveX = visibleBounds.origin.x + panView.size.width * 0.5
        } else if moveX > visibleBounds.origin.x + visibleBounds.width - panView.size.width * 0.5 {
            moveX = visibleBounds.origin.x + visibleBounds.width - panView.size.width * 0.5
        }

        var moveY = point.y
        if moveY < visibleBounds.origin.y + panView.size.height * 0.5 {
            moveY = visibleBounds.origin.y + panView.size.height * 0.5
        } else if moveY > visibleBounds.origin.y + visibleBounds.height - panView.size.height * 0.5
        {
            moveY = visibleBounds.origin.y + visibleBounds.height - panView.size.height * 0.5
        }

        panView.snp.remakeConstraints { (make) in
            make.left.equalTo(moveX - panView.width * 0.5)
            make.top.equalTo(moveY - panView.height * 0.5)
            make.size.equalTo(panView.frame.size)
        }
    }
}
