//
//  ViewControllerOverlayTransitionAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation

public final class ViewControllerOverlayTransitionAnimationController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: - Properties
    
    public var overlay: ViewControllerOverlay?
    
    // MARK: - Init
    
    public convenience override init() {
        self.init(overlay: .none)
    }
    
    public init(overlay: ViewControllerOverlay?) {
        self.overlay = overlay
        super.init()
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let overlay: ViewControllerOverlay = self.overlay {
            return ViewControllerOverlayAnimator(overlay: overlay, isPresenting: true)
        } else {
            return .none
        }
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let overlay: ViewControllerOverlay = self.overlay {
            return ViewControllerOverlayAnimator(overlay: overlay, isPresenting: false)
        } else {
            return .none
        }
    }
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presentable: UIViewController & ViewControllerPresentable = presented as? (UIViewController & ViewControllerPresentable), let overlay: ViewControllerOverlay = self.overlay else {
            return .none
        }
        let result: ViewControllerOverlayTransitionPresentationController = ViewControllerOverlayTransitionPresentationController(
            overlay: overlay,
            presentedViewController: presentable,
            presenting: presenting
        )
        result.tapDelegate = self.tapDelegate
        return result
    }
}
