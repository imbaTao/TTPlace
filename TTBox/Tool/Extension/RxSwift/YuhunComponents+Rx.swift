//
//  TTBoxComponents.swift
//  TTBox
//
//  Created by Mr.hong on 2021/1/13.
//

import Foundation

//MARK: - 扩展rx方法,按钮未选中颜色
extension Reactive where Base: UIButton {

    /*
        button isEnable与否的两种情况下对应的 backgroudColor
     */
    public var isEnabledBgColor: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.backgroundColor = value ? rgba(143, 64, 246, 1) : rgba(230, 230, 230, 1)
        }
    }

    // 选中的border
    public var isSelectedBorderColor: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.borderColor = value ? rgba(143, 64, 246, 1) : rgba(204, 204, 204, 1)
            control.borderWidth = 1
        }
    }
}
