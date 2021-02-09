//
//  MessageListViewModel.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/8.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
class FriendListViewModel: TTTableViewViewModel {
    override func fetchData(compltetBlock: @escaping (Bool, [HandyJSON]?) -> ()) {
        compltetBlock(true,[HandyJSON]())
    }
}
