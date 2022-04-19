//
//  Bundle+Extensions.swift
//  AlertMessagesTrial
//
//  Created by zeinadesouky on 22/03/2022.
//

import Foundation

extension Bundle {

    static func loadView<T>(fromClass: T.Type) -> T {
        let className = String(describing: fromClass)
        if let view = Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("Could not load view with type \(className)")
    }
}
