//
//  ViewControllerModalTransitionController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/6/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

public final class ViewControllerModalTransitionController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerModalAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerModalAnimator(isPresenting: false)
    }
}
