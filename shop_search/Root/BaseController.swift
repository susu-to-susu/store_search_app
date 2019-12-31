//
//  BaseController.swift
//  shop_search
//
//  Created by susu on 2019/12/30.
//  Copyright © 2019 susu. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    // viewがロードされた後、１回だけ
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // viewが表示される直前
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなった時
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

}

