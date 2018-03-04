//
//  ViewControllerPeekAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

public final class ViewControllerPeekTransitionAnimationController: ViewControllerDefaultTransitionAnimationController {
        
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerPeekAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let interactiveDismissal: ViewControllerPeekInteractiveDismissable = dismissed as? ViewControllerPeekInteractiveDismissable {
            return ViewControllerPeekAnimator(
                isPresenting: false,
                interactiveDismissalController: interactiveDismissal.interactiveTransitioning
            )
        } else {
            return ViewControllerPeekAnimator(isPresenting: false)
        }
    }
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ViewControllerPeekTransitionPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let peekAnimator: ViewControllerPeekAnimator = animator as? ViewControllerPeekAnimator,
            let interactiveDismissale: ViewControllerPeekInteractiveDismissalController = peekAnimator.interactiveDismissalController,
            interactiveDismissale.interactionInProgress {
            return interactiveDismissale
        } else {
            return .none
        }
    }

}
