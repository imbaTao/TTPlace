//
//  DynamicPublishEditTitleCellViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
class DynamicPublishEditTitleCellViewModel: TableViewCellViewModel {
    init(with title: String) {
        super.init()
        self.title.accept(title)
    }
}
