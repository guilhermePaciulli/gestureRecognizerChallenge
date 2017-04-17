//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Guilherme Paciulli on 17/04/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let v = recognizer.velocity(in: self.view)
            let m = sqrt((v.x * v.x) + (v.y * v.y))
            let sM = m / 200
            print("Magnitude: \(m), Slide multiplier: \(sM)")
            let sF = 0.1 * sM
            var fP = CGPoint(x: (recognizer.view?.center.x)! + (v.x * sF),
                             y: (recognizer.view?.center.y)! + (v.y * sF))
            fP.x = min(max(fP.x, 0), self.view.bounds.size.width)
            fP.y = min(max(fP.y, 0), self.view.bounds.size.height)
            
            UIView.animate(withDuration: Double(sF * 2),
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: { recognizer.view!.center = fP },
                           completion: nil)
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

