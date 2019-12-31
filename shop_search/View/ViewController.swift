//
//  ViewController.swift
//  shop_search
//
//  Created by susu on 2019/12/29.
//  Copyright © 2019 susu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: BaseController, UITableViewDataSource, UITableViewDelegate {
    // WebAPIからの取得情報
    var gnavicles: [[String: String?]] = []
    
    // プロパティにtableを追加
    let table = UITableView()
    var error_code = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "検索結果一覧"
        table.frame = view.frame // tableの大きさをviewの大きさに合わせる
        view.addSubview(table) // viewにtableを乗せる
        table.dataSource = self
        table.delegate = self
        
        // ぐるなび検索WebAPIを実行
        getGnaviSearchList()
    }
    
    // ぐるなび検索WebAPIを実行
    func getGnaviSearchList() {
        // APIリクエスト
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=ccf1418d89c96ed9c48b214c74fb2f06&latitude=" + String(Cordinate.sharedCordinate.nowLatitude) + "&longitude=" + String(Cordinate.sharedCordinate.nowLongtitude) + "&range=2"
        print("url : " + url)   //デバッグ用

        Alamofire.request(
            url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default
        ).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            
            /*
             * ------------------------------------------------------------
             * JSON -> 辞書へキャスト
             * 辞書 -> Listへキャスト
             * 時間もあれだったので、今後クラス化 or メソッド化する必要がある
             * 固定で受け取っているため、エラーの場合を細かく考慮する
             * Apple Developer Programが、12/31の12時に利用許可が降りたため、
             * ほぼ設計を行っていない。
             *
             * ------------------------------------------------------------
             */
            let json = JSON(object)
            json.forEach { (keyid, json) in
                // 配列構造の辞書になっているため、すべてList化(一覧化)
                if(keyid == "rest"){
                    json.forEach { (rest_keyid, rest_value) in
                        print("name : " + rest_value["name"].string!)
                        let article: [String: String?] = [
                            "name": rest_value["name"].string!,
                            "category":rest_value["category"].string!,
                            "url":rest_value["url"].string!
                        ]
                        self.gnavicles.append(article)
                    }
                    self.table.reloadData()
                } else if (keyid == "error") {
                    var error_message = ""
                    json.forEach { (error_keyid, error_value) in
                        error_message = error_value["message"].string!
                        self.error_code = error_value["code"].int!
                    }
                    self.alert(title: "Error : \(self.error_code)", message: "\(error_message)")
                }
            }
        }
    }
    
    // アラート
    func alert(title:String, message:String) {
        let alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gnavicles.count
    }

    // テーブルの各セルに格納
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = gnavicles[indexPath.row]
        cell.textLabel?.text = article["category"]!
        cell.detailTextLabel?.text = article["name"]!
        return cell
    }

    // テーブルのセルクリック
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(0 == error_code){
            // 配列からデータ取得
            print("indexPath : \(indexPath)")
            let article = gnavicles[indexPath.row]
            guard let url_string = article["url"] else {
                // アラート
                alert(title: "エラー", message: "お店のページ情報がありません。")
                return
            }
            let url = URL(string:url_string!)
            // URLを開く
            if( UIApplication.shared.canOpenURL(url!) ) {
              UIApplication.shared.open(url!)
            }
        }
    }

}




