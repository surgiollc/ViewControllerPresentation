//
//  ViewControllerExpandAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 7/17/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

final class ViewControllerExpandAnimator: NSObject {
    
    // MARK: - Properties
    
    private let isPresenting: Bool
    private let originFrame: CGRect
    
    // MARK: - Init
    
    public init(isPresenting: Bool, originFrame: CGRect) {
        self.isPresenting = isPresenting
        self.originFrame = originFrame
    }
}
// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerExpandAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3
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
            viewController.view.frame = self.originFrame
        } else {
            finalFrame = self.originFrame
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            viewController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
