//
//  ViewController.swift
//  ChartDrawingDemo
//
//  Created by Tejas Patelia on 05/07/21.
//

import UIKit

class ViewController: UIViewController {



	@IBOutlet private weak var uiview1: UIView!
	@IBOutlet private weak var uiview2: UIView!
	@IBOutlet private weak var heightC1: NSLayoutConstraint!
	@IBOutlet private weak var heightC2: NSLayoutConstraint!
	private var isAnimating = false
//	let point1 = CGPoint(x: 100, y: 100)
//	let point2 = CGPoint(x: 200, y: 200)
	let shapeLayer = CAShapeLayer()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.layer.addSublayer(shapeLayer)
		heightC1.constant = 0
		heightC2.constant = 0
		let point1 = CGPoint(x: uiview1.frame.midX, y: uiview1.frame.origin.y)
		let point2 = CGPoint(x: uiview2.frame.midX, y: uiview2.frame.origin.y)
//		addLinePath(between: point1, and: point2)
		view.layer.addSublayer(shapeLayer)

		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.blue.cgColor
		shapeLayer.lineWidth = 2.0
//		let point1 = CGPoint(x: 100, y: 200)
//		let point2 = CGPoint(x: 200, y: 200)

	}

}


extension ViewController {
	@IBAction func buttonAction() {
		guard !isAnimating else {return}
		UIView.animate(withDuration: 1.5, delay: 1, options: UIView.AnimationOptions.curveEaseInOut) { [self] in
			let point1 = CGPoint(x: self.uiview1.frame.midX, y: self.uiview1.frame.origin.y)
			let point2 = CGPoint(x: self.uiview2.frame.midX, y: self.uiview2.frame.origin.y)
			shapeLayer.path = addLinePath(between: point1, and: point2).cgPath
			self.heightC1.constant = 100
			self.heightC2.constant = 190
//			print(self.heightC1.constant)
//			print(self.heightC2.constant)

//			let point11 = CGPoint(x: self.uiview1.frame.midX, y: (self.heightC1.constant))
//			let point22 = CGPoint(x: self.uiview2.frame.midX, y: (self.heightC2.constant))

			let point11 = CGPoint(x: self.uiview1.frame.midX, y: (self.uiview1.frame.origin.y-self.heightC1.constant))
			let point22 = CGPoint(x: self.uiview2.frame.midX, y: (self.uiview2.frame.origin.y-self.heightC2.constant))
			let strokeColorAnimation = CABasicAnimation(keyPath: "strokeColor")
			strokeColorAnimation.toValue = UIColor.cyan.cgColor
			strokeColorAnimation.fillMode = .forwards
			strokeColorAnimation.isRemovedOnCompletion = false
			strokeColorAnimation.duration = 0.75
			strokeColorAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
			strokeColorAnimation.autoreverses = false
			strokeColorAnimation.repeatCount = 1
			shapeLayer.add(strokeColorAnimation, forKey: "strokeColorAnimation")

			let pathAnimation = CABasicAnimation(keyPath: "path")
			pathAnimation.toValue = addLinePath(between: point11, and: point22).cgPath
			pathAnimation.fillMode = .forwards
			pathAnimation.isRemovedOnCompletion = false
			pathAnimation.duration = 1
			pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
			pathAnimation.autoreverses = false
			pathAnimation.repeatCount = 0
			self.shapeLayer.add(pathAnimation, forKey: "pathAnimation")
		} completion: { (state) in
			if state == true {
				self.isAnimating = true
			}
		}
		UIView.animate(withDuration: 1, animations: {
			self.view.layoutIfNeeded()
		})

//		UIView.animate(withDuration: 0.8, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) { [unowned self] in
//			let pathAnimation = CABasicAnimation(keyPath: "path")
//			let point11 = CGPoint(x: 100, y: 100)
//			let point22 = CGPoint(x: 200, y: 100)
//			pathAnimation.fillMode = .forwards
//			pathAnimation.isRemovedOnCompletion = false
//			pathAnimation.toValue = addLinePath(between: point11, and: point22).cgPath
//			pathAnimation.fillMode = .forwards
//			pathAnimation.isRemovedOnCompletion = false
//			pathAnimation.duration = 0.8
//			pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//			pathAnimation.autoreverses = false
//			pathAnimation.repeatCount = 1
//			self.shapeLayer.add(pathAnimation, forKey: "pathAnimation")
//
//		}

	}

	private func addLinePath(between point1: CGPoint, and point2: CGPoint) -> UIBezierPath {
		let linePath = UIBezierPath()
		linePath.move(to: point1)
		linePath.addLine(to: point2)
		linePath.close()
		return linePath
	}
	
}
