//
//  ViewController.swift
//  AlertMessagesTrial
//
//  Created by zeinadesouky on 22/03/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func showMessageButton(_ sender: Any) {
        lazy var bannerView = BannerView.instanceFromNib()
        bannerView.setAction {
            print("Working")
        }
        bannerView.showBanner(theme: Theme.warning,
                              bodyText: "This operation might lead to a future error",
                              roundedCornerRadius: 8,
                              animationDuration: 0.9,
                              hideDelay: 5,
                              hideButton: false)
//                view.addSubview(bannerView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
