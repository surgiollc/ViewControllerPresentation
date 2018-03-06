//
//  ViewControllerPushInteractiveController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/5/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

public protocol ViewControllerPushInteractiveDismissable {
    
    var interactiveTransitioning: ViewControllerPushInteractiveDismissalController? { get }
}

public final class ViewControllerPushInteractiveDismissalController: UIPercentDrivenInteractiveTransition {
    
    public static let percentThreshold: CGFloat = 0.3 // The user needs to swipe down 30% to trigger a dismissal
    
    public private(set) var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    public init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        self.prepareGestureRecognizer(in: self.viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let recognizer: UIGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(self.handleGesture(_:))
        )
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let percentThreshold: CGFloat = ViewControllerPushInteractiveDismissalController.percentThreshold
        let translation: CGPoint = recognizer.translation(in: self.viewController.view)
        let horizontalMovement: CGFloat = translation.x / self.viewController.view.bounds.width
        let leftMovement: Float = fmaxf(Float(horizontalMovement), 0.0)
        let leftMovementPercent: Float = fminf(leftMovement, 1.0)
        let progress: CGFloat = CGFloat(leftMovementPercent)
        
//        print(progress)
        
        guard let viewController: UIViewController = self.viewController else { return }
        
        switch recognizer.state {
        case .began:
            self.interactionInProgress = true
            viewController.dismiss(animated: true, completion: .none)
        case .changed:
            self.shouldCompleteTransition = progress > percentThreshold
            self.update(progress)
        case .cancelled:
            self.interactionInProgress = false
            self.cancel()
        case .ended:
            self.interactionInProgress = false
            self.shouldCompleteTransition
                ? self.finish()
                : self.cancel()
        default:
            break
        }
    }
}
