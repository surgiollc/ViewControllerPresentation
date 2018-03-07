//
//  ModalViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 3/6/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

final class ModalViewController: UIViewController {
    
    override var preferredContentSize: CGSize {
        get {
            return UIScreen.main.bounds.size
        }
        set {}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .green
    }


}
