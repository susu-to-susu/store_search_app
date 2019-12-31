//
//  Coordinate.swift
//  shop_search
//
//  Created by susu on 2019/12/31.
//  Copyright © 2019 susu. All rights reserved.
//

import Foundation

// 座標保存
class Cordinate {
    // 緯度経度
    var lat:Double
    var lng:Double
    
    // シングルトン化
    static let sharedCordinate = Cordinate()
    
    // 初期化
    private init() {
        lat = 0.0
        lng = 0.0
    }

    // 緯度setter/getter
    var nowLatitude:Double {
        get{
            return self.lat
        }
        set(value){
            lat = ceil(value*1000)/1000
        }
    }
    
    // 経度setter/getter
    var nowLongtitude:Double {
        get{
            return self.lng
        }
        set(value){
            lng = ceil(value*1000)/1000
        }
    }

}
