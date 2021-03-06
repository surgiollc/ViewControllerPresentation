//
//  ViewControllerPushAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/5/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

final class ViewControllerPushAnimator: NSObject {

    // MARK: - Init
    
    private let isPresenting: Bool
    internal let interactiveDismissalController: ViewControllerPushInteractiveDismissalController?

    // MARK: - Init
    
    public convenience init(isPresenting: Bool) {
        self.init(isPresenting: isPresenting, interactiveDismissalController: .none)
    }
    
    public init(isPresenting: Bool, interactiveDismissalController: ViewControllerPushInteractiveDismissalController?) {
        self.isPresenting = isPresenting
        self.interactiveDismissalController = interactiveDismissalController
        super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerPushAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let viewController: UIViewController
        let containerView: UIView = transitionContext.containerView
        if self.isPresenting {
            viewController = transitionContext.viewController(forKey: .to)!
            containerView.addSubview(viewController.view)
        } else {
            viewController = transitionContext.viewController(forKey: .from)!
        }
        let animationDuration: TimeInterval = transitionDuration(using: transitionContext)
        var finalFrame: CGRect = transitionContext.finalFrame(for: viewController)
        if self.isPresenting {
            let fromViewController: UIViewController = transitionContext.viewController(forKey: .from)!
            viewController.view.frame = CGRect(
                x: fromViewController.view.bounds.width,
                y: fromViewController.view.frame.origin.y,
                width: finalFrame.size.width,
                height: finalFrame.size.height
            )
        } else {
            finalFrame = CGRect(
                x: viewController.view.bounds.width,
                y: viewController.view.frame.origin.y,
                width: finalFrame.size.width,
                height: finalFrame.size.height
            )
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            viewController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
