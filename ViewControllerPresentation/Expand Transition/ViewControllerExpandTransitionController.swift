//
//  ViewControllerExpandAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 7/17/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

public final class ViewControllerExpandTransitionController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: - Properties
    
    public var originFrame: CGRect?
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame: CGRect = self.originFrame else {
            return .none
        }
        return ViewControllerExpandAnimator(isPresenting: true, originFrame: frame)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame: CGRect = self.originFrame else {
            return .none
        }
        return ViewControllerExpandAnimator(isPresenting: false, originFrame: frame)
    }
}
