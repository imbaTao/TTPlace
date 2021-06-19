//
//  TTNewTableViewController.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/11.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation





class BaseRow: TTStaticRow {
    override func makeUI() {
        super.makeUI()
        contentView.backgroundColor = .systemPink
    }

    
    override func updateUI() {
        super.updateUI()
        rowHeight = 100
    }
    
    
}


class MyRow: BaseRow {
    func calculate() -> Self {
        return self
    }
}

class MyRow2: BaseRow {
    override func updateUI() {
        super.updateUI()
        rowHeight = 50
    }
}


class BetterStaticListVC: TTStaticListController {
    override func makeUI() {
        super.makeUI()
        
        let row1 = MyRow().header { (header) in
            
        }
        
        addRows([row1])
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        TTStoreEvaluateManager.evaluate()
    }
}


/**
 我希望设置参数后，快速得到一个列表，只需要重点展示cell就好，点击事件提出来
 先想想
 */

class TempVC: ViewController {
    let tableView = TTStaticTableView()
    override func makeUI() {
        
//        tableView.configCellBlock = { (indexPath) in
//
//
//            return UITableViewCell()
//        }
        
        
        
    }
}






class TTTableViewConfig: NSObject {
    // 直接配数据源
    var data = [Any]()
    
}



// 先想静态的,用于快速分行
class TTStaticTableView: TTTableView,UITableViewDelegate,UITableViewDataSource {
    var config = TTTableViewConfig()
    var configCellBlock: ((IndexPath) -> (UITableViewCell))?
    override func makeUI() {
        super.makeUI()
        
        
        self.delegate = self
        self.dataSource = self
    }
    
    

    /// MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if style == .grouped {
            // 如果是分组里有数据的话，就返回子分组里的数据
            if let subModels = config.data[section] as? [HandyJSON] {
                return subModels.count
            }
        }
    
        return config.data.count
    }
    
    // 返回什么样的tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let configCellBlock = self.configCellBlock {
            return configCellBlock(indexPath)
        }
        
        assert(false, "请配置configCellBlock")
        return UITableViewCell()
    }
}
