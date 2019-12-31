//
//  SearchViewController.swift
//  shop_search
//
//  Created by susu on 2019/12/31.
//  Copyright © 2019 susu. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import CoreMotion

class SearchViewController: BaseController, CLLocationManagerDelegate {
    // 緯度軽度変数
    var lat:Double = 0
    var lng:Double = 0

    // Location関係
    var locationManager: CLLocationManager!
    let motionManager = CMMotionManager()

    // UIプロパティ
    @IBOutlet weak var latText: UILabel!
    @IBOutlet weak var lngText: UILabel!

    // 初期表示時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 位置情報取得
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        // ログイン無しで、次画面遷移(Sign In with Appleが実装できないため)
        self.performSegue(withIdentifier: "viewController", sender: nil)
    }

    // 権限チェック
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            fatalError()
        }
    }

    // 受信結果定期実行
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                latText.text = "Error"
                lngText.text = "Error"
                return
        }

        latText.text = "".appendingFormat("%.4f", newLocation.coordinate.latitude)
        lngText.text = "".appendingFormat("%.4f", newLocation.coordinate.longitude)
        print(latText.text!)
        print(lngText.text!)
        Cordinate.sharedCordinate.nowLatitude = newLocation.coordinate.latitude
        Cordinate.sharedCordinate.nowLongtitude = newLocation.coordinate.longitude
    }
}
