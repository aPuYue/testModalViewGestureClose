//
//  ViewController.swift
//  testModalViewGestureClose
//
//  Created by puyue on R 3/05/14.
//

import UIKit

class ViewController: UIViewController {

    let interactor = Interactor()
    
    @IBAction func open(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)//SB 文件名称
        let vc = sb.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController//左边是IB内看到的 VC 的[storyboard ID]属性值,右边是 Class 名称
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        vc.interactor = interactor
        self.present(vc, animated: true, completion: nil)
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

