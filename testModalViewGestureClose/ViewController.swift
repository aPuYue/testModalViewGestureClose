//
//  ViewController.swift
//  testModalViewGestureClose
//
//  Created by puyue on R 3/05/14.
//

import UIKit

class ViewController: UIViewController {

    let interactor = Interactor()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ModalViewController {
            destinationViewController.modalPresentationStyle = .fullScreen;
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

