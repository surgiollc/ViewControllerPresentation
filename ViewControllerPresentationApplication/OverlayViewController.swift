//
//  PresentedViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class OverlayViewController: UIViewController, ViewControllerPresentable {
    
    var customBackgroundView: UIView? {
        return .none
    }
    
    var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    static let defaultWidth: CGFloat = 200
    static let defaultHeight: CGFloat = 200

    public override var preferredContentSize: CGSize {
        get {
            return CGSize(width: type(of: self).defaultWidth, height: type(of: self).defaultHeight)
        }
        set {}
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
