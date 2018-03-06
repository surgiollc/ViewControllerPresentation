//
//  ViewControllerPushTransitionController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/5/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

public final class ViewControllerPushTransitionController: ViewControllerDefaultTransitionAnimationController {

    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerPushAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let interactiveDismissal: ViewControllerPushInteractiveDismissable = dismissed as? ViewControllerPushInteractiveDismissable {
            return ViewControllerPushAnimator(
                isPresenting: false,
                interactiveDismissalController: interactiveDismissal.interactiveTransitioning
            )
        } else {
            return ViewControllerPeekAnimator(isPresenting: false)
        }
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let pushAnimator: ViewControllerPushAnimator = animator as? ViewControllerPushAnimator,
            let interactiveDismissale: ViewControllerPushInteractiveDismissalController = pushAnimator.interactiveDismissalController,
            interactiveDismissale.interactionInProgress {
            return interactiveDismissale
        } else {
            return .none
        }
    }
}
