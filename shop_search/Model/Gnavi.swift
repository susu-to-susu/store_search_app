//
//  Model.swift
//  shop_search
//
//  Created by susu on 2019/12/30.
//  Copyright © 2019 susu. All rights reserved.
//

import Foundation
import UIKit

// Modelに格納する予定であったが、期限が短く、余裕があったら手を付ける
// JSON -> 辞書形式に変換して、対象のものだけ取り出す方式に変更
// Model格納した方が保守性あるが、いまは機能の実現を最優先にした。
struct Gnavi: Codable {
//    var id: String
//
//    var type: String
    
    // @attributes
//    struct attributes : Codable{
//        var api_version: String
//    }
//    var api_version: String?
//    var total_hit_count: Int?
//    var hit_per_page: Int?
//    var page_offset: Int?
//
//    struct Rest : Codable{
//        var id: String?
////        var update_date: String?
//        var name: String?
//        var name_kana: String?
//        var latitude: String?
//        var longitude: String?
//        var category:String?
//        var url: PartialURL?
//        var url_mobile: PartialURL?
//        struct Coupon_url : Codable{
//            var pc: PartialURL?
//            var mobile: PartialURL?
//        }
//        var coupon_url : Coupon_url
//
//        struct Image_url : Codable{
//            var shop_image1: PartialURL?
//            var shop_image2: PartialURL?
//            var qrcode: PartialURL?
//        }
//        var image_url : Image_url
//
//        var address: String?
//        var tel: String?
//        var tel_sub: String?
//        var fax: String?
//        var opentime: String?
//        var holiday: String?
//        struct Access : Codable{
//            var line: String?
//            var station: String?
//            var station_exit: String?
//            var walk: String?
//            var note: String?
//        }
//        var access : Access
//
//        var parking_lots: String?
//        struct Pr : Codable{
//            var pr: String?
//            var pr_long: String?
//        }
//        var pr : Pr
//
//        struct Code : Codable{
//            var areacode: String?
//            var areaname: String?
//            var prefcode: String?
//            var prefname: String?
//            var areacode_s: String?
//            var areaname_s: String?
////            struct category_code_l : Codable{
////                var order: String?
////            }
////            struct category_name_l : Codable{
////                var order: String?
////            }
////            struct category_code_s : Codable{
////                var order: String?
////            }
////            struct category_name_s : Codable{
////                var order: String?
////            }
//        }
//        var code : Code
//
//        var budget: Int?
//        var party: Int?
//        var lunch: Int?
//        var credit_card: String?
//        var e_money: String?
//        struct Flags : Codable{
//            var mobile_site: Int?
//            var mobile_coupon: Int?
//            var pc_coupon: Int?
//        }
//        var flags : Flags
//    }
//
//    var rest : Rest

}


