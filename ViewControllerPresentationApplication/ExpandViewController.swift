//
//  ExpandViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 7/17/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class ExpandViewController: UIViewController, ViewControllerPresentable {
    
    var customBackgroundView: UIView? {
        return .none
    }
    
    var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    override var preferredContentSize: CGSize {
        get {
            return UIScreen.main.bounds.size
        }
        set {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

}
