//
//  TTControllSectedItem.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/2.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


// 这个对象包裹需要点击的item,还有配置对象，需要反选的时候加入进来
class TTControllSectedItemConfig: NSObject {
    // 选中颜色
    var selectedBackGroundColor = UIColor.red
    
    // 未选中颜色
    var unSelectedBackGroundColor = UIColor.white
    
    
    
    // 选中背景图
    var selectedBackGroundImage: UIImage?
    
    // 未选中背景图
    var unselectedBackGroundImage: UIImage?
    
    
    
    // 描边颜色
    var selectedBorderColor = UIColor.black
    var unSelectedBorderColor = UIColor.clear
    
    // 描边宽度
    var borderWidth = 1.0
}
 

class TTControllSelectBar: View {
    var config = TTControllSectedItemConfig()
    var controls = [UIButton]()
    var currentItemIndex = 0
    
    init(_ configClosure: ((_ config: TTControllSectedItemConfig) -> Void)?) {
        super.init(frame: .zero)
        if controls.count < 2 {
//            assert(false, "必须要2个及以上的Control才行")
        }
        configClosure?(self.config)
    }
    
    
    func addControl(_ control: UIButton,_ index: Int) {
        controls.append(control)
        control.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.selectedAction(control)
            self.currentItemIndex = index
        }).disposed(by: rx.disposeBag)
        addSubviews(controls)
    }
    
    func addControls(_ controls: [UIButton]) {
        self.controls = controls
        for index in 0..<controls.count {
            let control = controls[index]
            control.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                self.selectedAction(control)
                self.currentItemIndex = index
            }).disposed(by: rx.disposeBag)
            addSubviews(controls)
        }
    }
    
    func configControls(_ controls: [UIButton])  {
        self.controls = controls
        for index in 0..<controls.count {
            let control = controls[index]
            control.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                self.selectedAction(control)
                self.currentItemIndex = index
            }).disposed(by: rx.disposeBag)
            addSubviews(controls)
        }
    }
    
    func selectedAction(_ control: UIButton) {
        for subControl in controls {
            if subControl != control {
                subControl.isSelected = false
            }else {
                subControl.isSelected = true
            }
            
            subControl.backgroundColor = subControl.isSelected ? config.selectedBackGroundColor : config.unSelectedBackGroundColor
            subControl.borderColor = subControl.isSelected ? config.selectedBorderColor : config.unSelectedBorderColor
            subControl.borderWidth = 1
            
            if config.selectedBackGroundImage != nil {
                subControl.setBackgroundImage(config.unselectedBackGroundImage, for: .normal)
                subControl.setBackgroundImage(config.selectedBackGroundImage, for: .selected)
            }
        }
    }
    
    
    // 选中第一个
    func selectFirst()  {
        selectedAction(controls.first!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
