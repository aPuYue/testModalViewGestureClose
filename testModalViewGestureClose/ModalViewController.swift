//
//  ModalViewController.swift
//  testModalViewGestureClose
//
//  Created by puyue on R 3/05/14.
//

import UIKit

class ModalViewController: UIViewController {

    var interactor:Interactor? = nil
    
    override func viewDidLoad() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
//        pan.delegate = self
//        pan.require(toFail: swipeGesture)
        self.view.addGestureRecognizer(pan)
        
//        let swipeGesture = UISwipeGestureRecognizer(
//            target: self,
//            action: #selector(swipe))
////        swipeGesture.delegate = self
//        swipeGesture.direction = .down
//        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func swipe() {
        print("@#$_swipe")
    }

    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.5 //打开到多少

        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)

        guard let interactor = interactor else { return }

        switch sender.state {
        case .began:
            print("@#$3")
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            print("@#$4")
            interactor.shouldFinish = progress > percentThreshold
            self.view.alpha = 1 - progress//实时改变透明度
            interactor.update(progress)
        case .cancelled:
            print("@#$5")
            interactor.hasStarted = false
            self.view.alpha = 1
            interactor.cancel()
        case .ended:
            print("@#$6")
            interactor.hasStarted = false
            self.view.alpha = 1
            interactor.shouldFinish
                ? interactor.finish()//关闭 view
                : interactor.cancel()//取消关闭
        default:
            print("@#$7")
            break
        }
    }
}
