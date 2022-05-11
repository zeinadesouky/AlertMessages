//
//  ViewController.swift
//  AlertMessagesTrial
//
//  Created by zeinadesouky on 22/03/2022.
//

import UIKit

class ViewController: UIViewController {
    lazy var bannerView = BannerView.instanceFromNib()
    @IBAction func showMessageButton(_ sender: Any) {
        bannerView.setAction {
            print("Working")
        }
        bannerView.showBanner(theme: Theme.success,
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
