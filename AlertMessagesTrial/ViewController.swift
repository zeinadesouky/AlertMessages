//
//  ViewController.swift
//  AlertMessagesTrial
//
//  Created by zeinadesouky on 22/03/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func showMessageButton(_ sender: Any) {
        let bannerView = BannerView.instanceFromNib()
        bannerView.showBanner(theme: Theme.success,
                              bodyText: "This operation might lead to a future error",
                              roundedCornerRadius: 8,
                              animationDuration: 0.5,
                              hideDelay: 2,
                              hideButton: false)
        bannerView.setAction {
            print("Working")
        }
//        view.addSubview(bannerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

