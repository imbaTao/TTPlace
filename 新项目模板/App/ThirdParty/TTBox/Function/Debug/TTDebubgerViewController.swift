//
//  TTDebubgerViewController.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit

class TTDebubgerViewController: TTViewController {
    override func makeUI() {
        super.makeUI()
        
        rootWindow().addSubview(TinyWindow.shared)
    }
}

