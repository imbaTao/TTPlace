//
//  TTButton.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/29.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import UIKit


public enum TTButtonState {
    case normal
    case normalHighlighted
    case normalDisabled
    case selected
    case selectedHighlighted
    case selectedDisabled
}


public enum TTButtonType {
    case iconOnTheTop
    case iconOnTheLeft
    case iconOnTheBottom
    case iconOnTheRight
    case justText
    case justIcon
    case doubleText
}

public class TTButton: UIControl   {
    // container
    private lazy var autoSizeView: TTAutoSizeView = {
        let autoSizeView = TTAutoSizeView()
        autoSizeView.isUserInteractionEnabled = false
        addSubview(autoSizeView)
        autoSizeView.snp.makeConstraints { (make) in
            make.edges.equalTo(_config.padding)
        }
        return autoSizeView
    }()
    
    public let icon = UIImageView.empty()
    
    public let titleLable = UILabel.regular(size: 12, textColor: .black)
    
    lazy var backGroundIcon: UIImageView = {
        var backGroundIcon = UIImageView.empty()
        addSubview(backGroundIcon)
        backGroundIcon.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        sendSubviewToBack(backGroundIcon)
        return backGroundIcon
    }()
    
    internal var _config  = TTButtonConfig()
    
    required init(_ configBlock: (_ config: TTButtonConfig) -> ()) {
        super.init(frame: .zero)
        configBlock(_config)
        
        // title and icon change by state
        defaultValueConfig()
      
        // oberver state change
        addTarget(self, action: #selector(stateDidChange), for: .valueChanged)
        
        refreshUI()
        
        // final layout
        layoutWithType(type: _config.type)
    }
    
    private func layoutWithType(type: TTButtonType) {
        autoSizeView.t_addSubViews([icon, titleLable])
        icon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        }
        refreshLayout()
    }
    
    func refreshLayout() {
        switch _config.type {
        case .iconOnTheTop:
            icon.snp.remakeConstraints { (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            titleLable.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(icon.snp.bottom).offset(_config.interval)
                make.bottom.equalToSuperview()
            }
        case .iconOnTheBottom:
            titleLable.snp.remakeConstraints { (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            icon.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(titleLable.snp.bottom).offset(_config.interval)
                make.bottom.equalToSuperview()
            }
        case .iconOnTheLeft:
            icon.contentMode = .scaleAspectFit
            icon.snp.remakeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
            }
            
            titleLable.snp.remakeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(icon.snp.right).offset(_config.interval)
            }
        case .iconOnTheRight:
            icon.contentMode = .scaleAspectFit
            titleLable.snp.remakeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
                make.right.equalTo(icon.snp.left).offset(-_config.interval)
            }
            
            icon.snp.remakeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(titleLable.snp.right).offset(_config.interval)
            }
        case .justText:
            icon.removeFromSuperview()
            titleLable.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        case .justIcon:
            titleLable.removeFromSuperview()
            icon.snp.remakeConstraints { (make) in
                // make.edges.equalToSuperview()
                make.center.equalToSuperview()
                make.size.lessThanOrEqualToSuperview()
            }
        default: break
        }
        
        
        // if forceIconSize add size constrains
        if let iconForceSize = _config.iconForceSize {
            icon.snp.makeConstraints { (make) in
                make.size.equalTo(iconForceSize)
            }
        }
        
        autoSizeView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview().inset(_config.padding)
        }
    }
    
    
    // reloadUI display
    func refreshConfig(_ configBlock: (_ config: TTButtonConfig) -> ()) {
        configBlock(_config)
        refreshUI()
        refreshLayout()
    }
    

    private func refreshUI() {
        titleLable.text = fetchTitle()
        titleLable.textColor = fetchTitleColor()
        titleLable.font = fetchTitleFont()
        titleLable.textAlignment = _config.textAlignment ?? .center
        
        icon.image = fetchIcon()
        backGroundIcon.image = fetchBackGroundIcon()
        backgroundColor = fetchBackGroundColor()
        
        borderColor = fetchBorderColor()
        borderWidth = _config.borderWidth
        
        if _config.cornerRadius != cornerRadius,cornerRadius == 0 {
            cornerRadius = _config.cornerRadius
        }

        _disableTitleColor()
    }
    
    private let deepColorState: UIControl.State  = [.disabled,.highlighted]
    private func _disableTitleColor() {
        if deepColorState.rawValue & state.rawValue != 0 {
            self.alpha = 0.5
        }else {
            self.alpha = 1
        }
    }
    
    // MARK: - FetchContent by current state
    private func fetchTitle() -> String {
        if let value = _config.titles[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let title = _config.titles[.selected] {
               return title
            }else {
                return _config.titles[.normal] ?? ""
            }
        }
    }
    
    private func fetchTitleColor() -> UIColor {
        if let value = _config.titleColors[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let color = _config.titleColors[.selected] {
               return color
            }else {
                return _config.titleColors[.normal] ?? UIColor.white
            }
        }
    }
    
    private func fetchTitleFont() -> UIFont {
        if let value = _config.titleFonts[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let font = _config.titleFonts[.selected] {
               return font
            }else {
                return _config.titleFonts[.normal] ?? UIFont.systemFont(ofSize: 16)
            }
        }
    }
    
    private func fetchIcon() -> UIImage? {
        if let value = _config.images[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let image = _config.images[.selected] {
               return image
            }else {
                return _config.images[.normal]
            }
        }
    }
    
    private func fetchBackGroundIcon() -> UIImage? {
        if let value = _config.backGroundImages[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let image = _config.backGroundImages[.selected] {
               return image
            }else {
                return _config.backGroundImages[.normal]
            }
        }
    }
    
    private func fetchBackGroundColor() -> UIColor? {
        if let value = _config.backgroundColors[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let color = _config.backgroundColors[.selected] {
               return color
            }else {
                return (_config.backgroundColors[.normal])
            }
        }
    }
    
    
    private func fetchBorderColor() -> UIColor? {
        if let value = _config.borderColors[translateState] {
            return value
        }else {
            if translateState == .selectedHighlighted || translateState == .selectedDisabled,let color = _config.borderColors[.selected] {
               return color
            }else {
                return (_config.borderColors[.normal])
            }
        }
    }
    
    
    
    func defaultValueConfig() {
        // 若果字体位置格式为nil，那么赋值默认值
        if _config.textAlignment == nil {
            switch _config.type {
            case .iconOnTheTop:
                _config.textAlignment = .center
            case .iconOnTheBottom:
                _config.textAlignment = .center
            case .iconOnTheLeft:
                _config.textAlignment = .right
            case .iconOnTheRight:
                _config.textAlignment = .left
            case .justText:
                _config.textAlignment = .center
            case .justIcon:
                _config.textAlignment = .center
            default: break
            }
        }
        
        // titles
//        if _config.titles[.normalHighlighted] == nil {
//            _config.titles[.normalHighlighted] = _config.titles[.normal]
//        }

//        if _config.titles[.normalDisabled] == nil {
//            _config.titles[.normalDisabled] = _config.titles[.normal]
//        }

//        if _config.titles[.selected] == nil {
//            _config.titles[.selected] = _config.titles[.normal]
//        }
//
//        if _config.titles[.selectedDisabled] == nil {
//            _config.titles[.selectedDisabled] = _config.titles[.selected]
//        }
//
//        if _config.titles[.selectedHighlighted] == nil {
//            _config.titles[.selectedHighlighted] = _config.titles[.selected]
//        }
    }
    
    @objc func stateDidChange() {
        refreshUI()
    }
    
    
    private var _currentState = UIControl.State.normal
    
    // MARK: - override
    public override var isEnabled: Bool {
        set {
            super.isEnabled = newValue
            checkStateChangedAndSendActions()
        }
        get {
            
            super.isEnabled
        }
    }
    
    public override var isSelected: Bool {
        set {
            super.isSelected = newValue
            checkStateChangedAndSendActions()
        }
        get {
            super.isSelected
        }
    }
    
    public override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            checkStateChangedAndSendActions()
        }
        get {
            super.isHighlighted
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        _currentState = state;
        super.touchesBegan(touches, with: event)
        checkStateChangedAndSendActions()
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        _currentState = state;
        super.touchesMoved(touches, with: event)
        checkStateChangedAndSendActions()
    }
    
    public  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _currentState = state;
        super.touchesEnded(touches, with: event)
        checkStateChangedAndSendActions()
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        _currentState = state;
        super.touchesCancelled(touches, with: event)
        checkStateChangedAndSendActions()
    }
    
    private func checkStateChangedAndSendActions() {
        if state != _currentState {
            _currentState = state
            sendActions(for: .valueChanged)
        }
    }
    
    // 系统转TTButtonState
    private var translateState: TTButtonState {
        var fStatus: TTButtonState = .normal
        switch state {
        case .normal:
            fStatus = .normal
        case [.normal, [.highlighted]]:
            fStatus = .normalHighlighted
        case [.normal,.disabled]:
            fStatus = .normalDisabled
        case .selected:
            fStatus = .selected
        case [.selected, .highlighted]:
            fStatus = .selectedHighlighted
        case [.selected,.disabled]:
            fStatus = .normalDisabled
        default:
            break
        }
        return fStatus
    }
    
    public func setTitle(_ title: String, state: TTButtonState) {
        _config.titles[state] = title
        refreshUI()
    }
    
    public func setTitleColor(_ color: UIColor?, state: TTButtonState) {
        _config.titleColors[state] = color
        refreshUI()
    }
    
    public func setIconImage(_ img: UIImage?, state: TTButtonState) {
        _config.images[state] = img
        refreshUI()
    }
    
    public func setBackgroundImage(_ img: UIImage?, state: TTButtonState) {
        _config.backGroundImages[state] = img
        refreshUI()
    }
    
    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = newValue
        }
        get {
            fetchBackGroundColor()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//extension TTButton {
////    // 设置不可用颜色
////    func config(normalBackgroundColor: UIColor, disableBackgroundColor: UIColor) {
////        self.rx.observeWeakly(Bool.self, "enabled").filterNil().subscribe(onNext: {
////            [weak self] (isEnabled) in guard let self = self else { return }
////            // 是否选中,选中的话重新触发一下，重新设置选中颜色
////            if self.isSelected, isEnabled {
////                self.isSelected = true
////            } else {
////                self.backgroundColor = isEnabled ? normalBackgroundColor : disableBackgroundColor
////            }
////        }).disposed(by: rx.disposeBag)
////    }
////
////    // 设置选中border颜色
////    func config(normalBorderColor: UIColor, selectedBorderColor: UIColor) {
////        self.rx.observeWeakly(Bool.self, "selected").subscribe(onNext: { [weak self] (isSelcted) in
////            guard let self = self else { return }
////            self.addBorder(
////                color: self.isSelected ? selectedBorderColor : normalBorderColor,
////                width: .onePointHeight)
////        }).disposed(by: rx.disposeBag)
////    }
////
////    // 设置不可用颜色
////    func config(normalBorderColor: UIColor, disabledBorderColor: UIColor) {
////        self.rx.observeWeakly(Bool.self, "enabled").subscribe(onNext: { [weak self] (isEnabled) in
////            guard let self = self else { return }
////            self.addBorder(
////                color: self.isEnabled ? normalBorderColor : disabledBorderColor,
////                width: .onePointHeight)
////        }).disposed(by: rx.disposeBag)
////    }
//}














public class TTButtonConfig: NSObject {
    var type: TTButtonType = .justText
    
    // the interval between icon and title
    var interval: CGFloat = 5
    var iconForceSize: CGSize?
    var padding: UIEdgeInsets = .zero
    
    
    
    var textAlignment: NSTextAlignment?
    var lineBreakMode: NSLineBreakMode = .byTruncatingTail
    var numberOfLines: Int = 1
    
    var titleColors: [TTButtonState : UIColor] = [:]
    var titleFonts: [TTButtonState : UIFont] = [:]
    var images: [TTButtonState : UIImage] = [:]
    var backGroundImages: [TTButtonState : UIImage] = [:]
    var titles: [TTButtonState : String] = [:]
    var borderColors: [TTButtonState : UIColor] = [:]
    var backgroundColors: [TTButtonState : UIColor] = [:]
    
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat = 0
}


/**
 用自定义的state，转换一层
 */

extension TTButton {
    //  MARK: - 单状态可能带图片的按钮
    class func singleStatus(
        font: UIFont = .regular(16), titleColor: UIColor = .black, title: String? = "",
        image: UIImage? = nil,type: TTButtonType = .justText,interval: CGFloat = 0.0) -> Self {
            let button = Self.init { config in
                // text
                config.titleFonts[.normal] = font
                config.titleColors[.normal] =  titleColor
                config.titles[.normal] = title
                config.images[.normal] = image
                config.interval = interval
                config.type = type
            }
            
            switch type {
            case .iconOnTheTop,.iconOnTheBottom:
                button.titleLable.setContentCompressionResistancePriority(.required, for: .vertical)
            case .iconOnTheLeft,.iconOnTheRight:
                button.titleLable.setContentCompressionResistancePriority(.required, for: .horizontal)
            default:
                break
            }
            return button
        }

}
