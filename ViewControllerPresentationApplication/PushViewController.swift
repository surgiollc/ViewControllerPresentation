//
//  PushViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 3/5/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

final class PushViewController: UIViewController, ViewControllerPushInteractiveDismissable {
    
    var interactiveTransitioning: ViewControllerPushInteractiveDismissalController?

    override var preferredContentSize: CGSize {
        get {
            return UIScreen.main.bounds.size
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        self.interactiveTransitioning = ViewControllerPushInteractiveDismissalController(viewController: self)
    }

}
