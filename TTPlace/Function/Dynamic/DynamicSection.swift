//
//  DynamicSection.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/7/2.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
enum DynamicSection {
    case setting(title: String, items: [DynamicSectionItem])
}

enum DynamicSectionItem {
    // Account
    case editTitle(viewModel: DynamicPublishEditContentCellViewModel)
    
//    case logoutItem(viewModel: SettingCellViewModel)
//
//    // My Projects
//    case repositoryItem(viewModel: RepositoryCellViewModel)
//
//    // Preferences
//    case bannerItem(viewModel: SettingSwitchCellViewModel)
//    case nightModeItem(viewModel: SettingSwitchCellViewModel)
//    case themeItem(viewModel: SettingCellViewModel)
//    case languageItem(viewModel: SettingCellViewModel)
//    case contactsItem(viewModel: SettingCellViewModel)
//    case removeCacheItem(viewModel: SettingCellViewModel)
//
//    // Support
//    case acknowledgementsItem(viewModel: SettingCellViewModel)
//    case whatsNewItem(viewModel: SettingCellViewModel)
}

extension DynamicSectionItem: IdentifiableType {
    typealias Identity = String
    var identity: Identity {
        switch self {
        case .editTitle(let viewModel): return viewModel.title.value ?? ""
        }
    }
}

extension DynamicSectionItem: Equatable {
    static func == (lhs: DynamicSectionItem, rhs: DynamicSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension DynamicSection: AnimatableSectionModelType, IdentifiableType {
    typealias Item = DynamicSectionItem

    typealias Identity = String
    var identity: Identity { return title }

    // 返回标题
    var title: String {
        switch self {
        case .setting(let title, _): return title
        }
    }

    // 数据源
    var items: [DynamicSectionItem] {
        switch  self {
        case .setting(_, let items): return items.map {$0}
        }
    }

    init(original: DynamicSection, items: [Item]) {
        switch original {
        case .setting(let title, let items): self = .setting(title: title, items: items)
        }
    }
}
