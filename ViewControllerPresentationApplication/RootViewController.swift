//
//  ViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class RootViewController: UIViewController {

    var transitionController: ViewControllerDefaultTransitionAnimationController? {
        didSet {
            self.transitionController?.tapDelegate = self
        }
    }
    
    var peekTransitionController: ViewControllerPeekTransitionAnimationController = ViewControllerPeekTransitionAnimationController()
    var pushTransitionController: ViewControllerPushTransitionController = ViewControllerPushTransitionController()
    var modalTransitionController: ViewControllerModalTransitionController = ViewControllerModalTransitionController()
    var expandTransitionController: ViewControllerExpandTransitionController = ViewControllerExpandTransitionController()
    
    
    public func presentOverlayViewController(animated: Bool, completion: (() -> Void)? = nil) {
        let vc = OverlayViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.transitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    public func peekNewViewController(animated: Bool, completion: (() -> ())? = nil) {
        let vc = PeekViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.peekTransitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    public func pushNewViewController(animated: Bool, completion: (() -> ())? = nil) {
        let vc = PushViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.pushTransitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    public func expandNewViewController(animated: Bool, completion: (() -> ())? = nil) {
        let vc = ExpandViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self.expandTransitionController
        self.present(vc, animated: animated, completion: completion)
    }
    
    @IBAction func pushTapped(_ sender: UIButton) {
        self.pushNewViewController(animated: true)
    }
    
    @IBAction func peekTapped(_ sender: UIButton) {
        self.peekNewViewController(animated: true)
    }
    
    @IBAction func expandTapped(_ sender: UIButton) {
        self.expandTransitionController.originFrame = sender.frame
        self.expandNewViewController(animated: true)
    }
    
    public func didTapContainer() {
        self.presentedViewController?.dismiss(animated: true, completion: .none)
    }
    
    private func presentOverlay(with entry: ViewControllerOverlay.Edge) {
        let exit: ViewControllerOverlay.Edge
        let position: ViewControllerOverlay.Position
        switch entry {
        case .top:
            exit = .bottom
            position = .top(20)
        case .left:
            exit = .right
            position = .left(20)
        case .bottom:
            exit = .top
            position = .bottom(20)
        case .right:
            exit = .left
            position = .right(20)
        }
        let overlay: ViewControllerOverlay = try! ViewControllerOverlay(entry: entry, exit: exit, position: position)
        self.transitionController = ViewControllerOverlayTransitionAnimationController(overlay: overlay)
        self.presentOverlayViewController(animated: true)
    }
    
    @IBAction func topButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .top)
    }
    
    @IBAction func leftButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .left)
    }
    
    @IBAction func bottomButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .bottom)
    }
    
    @IBAction func rightButtonSelected(_ sender: UIButton) {
        self.presentOverlay(with: .right)
    }

}

