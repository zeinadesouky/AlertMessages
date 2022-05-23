//
//  BannerView.swift
//  AlertMessagesTrial
//
//  Created by zeinadesouky on 22/03/2022.
//

import UIKit

class BannerView: UIView {
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBAction private func messageButtonAction(_ sender: Any) {
        buttonClosure?()
    }
class func instanceFromNib() -> BannerView {
        Bundle.loadView(fromClass: BannerView.self)
    }
    // MARK: - Variables
    var buttonClosure: ( () -> Void)?
    var topConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    let superView = UIApplication.shared.keyWindow!.rootViewController!.view!
    // MARK: - Configure View Layout
    private func configureBgView(bgColor: UIColor) {
        backgroundView.layer.opacity = 1
        backgroundView.backgroundColor = bgColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(backgroundView)
        heightConstraint = NSLayoutConstraint(item: backgroundView!,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .notAnAttribute,
                                              multiplier: 1,
                                              constant: 0)
        topConstraint = NSLayoutConstraint(item: backgroundView!,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: superView,
                                           attribute: .top,
                                           multiplier: 1,
                                           constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundView!,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: superView,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: backgroundView!,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: superView,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: 0)

        topConstraint?.isActive = true
        heightConstraint?.isActive = true
        NSLayoutConstraint.activate([ trailingConstraint, leadingConstraint ])

        heightConstraint?.constant = 0
        trailingConstraint.constant = -5
        leadingConstraint.constant = 5
        superView.layoutIfNeeded()
    }
    // MARK: - Round View Corners
    private func roundViewCorners(roundedCornerRadius: CGFloat) {
        backgroundView.layoutIfNeeded()
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = roundedCornerRadius
    }
    // MARK: - Configure button
    private func configureMessageButton(buttonLabelColor: UIColor) {
        messageButton.backgroundColor = UIColor.white
        messageButton.layer.cornerRadius = 6
        messageButton.layer.shadowColor = UIColor(named: "buttonShadow")?.cgColor
        messageButton.layer.shadowOpacity = 0.6
        messageButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        messageButton.layer.borderWidth = 1
        messageButton.layer.borderColor = UIColor.white.cgColor
        messageButton.titleLabel?.textColor = buttonLabelColor
    }
    func setAction(closure: @escaping () -> Void) {
        buttonClosure = closure
    }
    // MARK: - Configure Title Label text and Labels colors
    private func set(titleText: String, titleColor: UIColor, bodyColor: UIColor) {
        titleLabel.text = titleText
        titleLabel.textColor = titleColor
        messageBody.textColor = bodyColor
    }
    // MARK: - Configure Body Label text
    private func set(bodyText: String) {
        messageBody.text = bodyText
        messageBody.numberOfLines = 0
        messageBody.lineBreakMode = .byWordWrapping
    }
    //
// MARK: - Set image
    private func set(messageIcon: UIImage? = nil) {
        leftIcon.image = messageIcon
    }

    private func display() {
        topConstraint?.constant = 44
        heightConstraint?.constant = 64

        UIView.animate(withDuration: 0.8) {
            self.superView.layoutIfNeeded()
        }
    }
    private func hide(view: UIView, for animationDuration: CGFloat, hideDelay: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDelay) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: [.allowUserInteraction, .curveLinear],
                       animations: {
            self.messageButton.alpha = 0.010000001
            self.topConstraint?.constant = 0 - view.frame.height
            self.superView.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                view.removeFromSuperview()
            }
        })
        }
    }

    private func configure(theme: Theme) {
        switch theme {
        case .success:
           let successBackgroundColor = UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)
            configureBgView(bgColor: successBackgroundColor)
            configureMessageButton(buttonLabelColor: successBackgroundColor)
            let image = UIImage(named: "successIcon")!
            set(messageIcon: image)
            set(titleText: "Success", titleColor: UIColor.white, bodyColor: UIColor.white)
        case .error:
            let errorBackgroundColor = UIColor.red
            configureBgView(bgColor: errorBackgroundColor)
            configureMessageButton(buttonLabelColor: errorBackgroundColor)
            let image = UIImage(named: "error")
            set(messageIcon: image)
            set(titleText: "Error", titleColor: UIColor.white, bodyColor: UIColor.white)
        case .warning:
            let warningBackgroundColor = UIColor(red: 246/255, green: 182/255, blue: 79/255, alpha: 1.0)
            configureBgView(bgColor: warningBackgroundColor)
            configureMessageButton(buttonLabelColor: warningBackgroundColor)
            let image = UIImage(named: "warning")
            set(messageIcon: image)
            set(titleText: "Warning!", titleColor: UIColor.white, bodyColor: UIColor.white)
        }
    }
    public func showBanner(theme: Theme,
                           bodyText: String,
                           roundedCornerRadius: CGFloat,
                           animationDuration: CGFloat,
                           hideDelay: CGFloat,
                           hideButton: Bool) {
        switch theme {
        case .success:
            configure(theme: theme)
        case .error:
            configure(theme: theme)
        case .warning:
            configure(theme: theme)
        }

        roundViewCorners(roundedCornerRadius: roundedCornerRadius)
        set(bodyText: bodyText)
        display()
        hide(view: backgroundView, for: animationDuration, hideDelay: hideDelay)

        if hideButton == true {
            messageButton.isHidden = true
        }
    }
}
