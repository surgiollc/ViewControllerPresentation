//
//  ViewControllerModalAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/6/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

final class ViewControllerModalAnimator: NSObject {
    
    // MARK: - Init
    
    private let isPresenting: Bool
    
    // MARK: - Init
    
    public init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerModalAnimator: UIViewControllerAnimatedTransitioning {
    
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
                x: 0,
                y: fromViewController.view.bounds.height,
                width: finalFrame.size.width,
                height: finalFrame.size.height
            )
        } else {
            finalFrame = CGRect(
                x: 0,
                y: viewController.view.bounds.height,
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
