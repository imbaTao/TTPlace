//
//  TTTouchMoveView.swift
//  sudi
//
//  Created by Mr.hong on 2021/10/9.
//  Copyright © 2021 BossMoney. All rights reserved.
//

import Foundation

class TTTouchMoveView: UIView {
    let visibleBounds: CGRect!
    
    init(moveVisibleBounds: CGRect) {
        self.visibleBounds = moveVisibleBounds
        
        super.init(frame: .zero)
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        addGestureRecognizer(pan)
    }
    
    @objc func panAction(_ guesture: UIPanGestureRecognizer) {
        let point = guesture.location(in: UIApplication.shared.windows.first!)
        
        var moveX = point.x
        if moveX < visibleBounds.origin.x + self.frame.size.width * 0.5   {
            moveX = visibleBounds.origin.x + self.frame.size.width * 0.5
        }else if moveX > visibleBounds.origin.x + visibleBounds.width - self.frame.size.width * 0.5 {
            moveX = visibleBounds.origin.x + visibleBounds.width - self.frame.size.width * 0.5
        }
        
        var moveY = point.y
        if moveY < visibleBounds.origin.y + self.frame.size.height * 0.5   {
            moveY = visibleBounds.origin.y + self.frame.size.height * 0.5
        }else if moveY > visibleBounds.origin.y + visibleBounds.height - self.frame.size.height * 0.5 {
            moveY = visibleBounds.origin.y + visibleBounds.height - self.frame.size.height * 0.5
        }
        
      
        self.center = .init(x: moveX, y: moveY)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
