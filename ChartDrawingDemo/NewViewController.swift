//
//  NewViewController.swift
//  ChartDrawingDemo
//
//  Created by Tejas Patelia on 21/07/21.
//

import UIKit

class NewViewController: UIViewController {

	@IBOutlet private weak var uiview: UIView!

	var difference = 50
	let array: [Int] = [50, 100, 150, 200]
	let drawArray: [Int] = [150, 100, 150, 50, 200]
	let shapeLayer = CAShapeLayer()
	let shapeLayer1 = CAShapeLayer()

	var viewArray: [UIView] = []
	var colorArray: [UIColor] = [.red, .yellow, .gray, .cyan]

	override func viewDidLoad() {
		super.viewDidLoad()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
		uiview.layer.addSublayer(shapeLayer)
		uiview.layer.addSublayer(shapeLayer1)

		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.blue.cgColor
		shapeLayer.lineWidth = 2.0

		shapeLayer1.fillColor = UIColor.clear.cgColor
		shapeLayer1.strokeColor = UIColor.orange.cgColor
		shapeLayer1.lineWidth = 2.0

		tapGesture.numberOfTapsRequired = 1
		uiview.addGestureRecognizer(tapGesture)
		viewArray = []
		for item in 1...4 {
			let uiviewNew: UIView = UIView(frame: CGRect(x: 0, y: difference*item , width: Int(self.view.bounds.width), height: 1))
			uiviewNew.backgroundColor = .red
			uiview.addSubview(uiviewNew)
		}

		UIView.animate(withDuration: 5.0, delay: 3, options: UIView.AnimationOptions.curveEaseInOut) {
			let newDiff = 50
			for (index,item) in self.drawArray.enumerated() {
				let uiviewNew = UIView(frame: CGRect(x: Int(CGFloat(newDiff*(index+1))), y: Int(self.uiview.bounds.height), width: 30, height: (item * -1)))
				uiviewNew.backgroundColor = .yellow
				self.viewArray.append(uiviewNew)
				self.uiview.addSubview(uiviewNew)
			}

			for i in 0..<self.viewArray.count {
				let shapeLayer = CAShapeLayer()
				if i+1 >= self.viewArray.count {break}
				let point1 = CGPoint(x: self.viewArray[i].frame.midX, y: CGFloat(self.uiview.bounds.height - CGFloat(self.drawArray[i])))
				//(x: viewArray[i].bounds.midX, y: drawArray[i])
				let point2 = CGPoint(x: self.viewArray[i+1].frame.midX, y: CGFloat(self.uiview.bounds.height - self.viewArray[i+1].bounds.height))
				shapeLayer.path = self.addLinePath(between: point1, and: point2).cgPath
				shapeLayer.strokeColor = UIColor.gray.cgColor
				shapeLayer.fillColor = UIColor.clear.cgColor
				shapeLayer.lineWidth = 2.0
				self.uiview.layer.addSublayer(shapeLayer)
			}
		} completion: { (state) in

		}




//		shapeLayer.path = addLinePath(between: CGPoint(x: 100, y: 100), and: CGPoint(x: 200, y: 200)).cgPath
//		shapeLayer1.path = addLinePath(between: CGPoint(x: 200, y: 200), and: CGPoint(x: 220, y: 20)).cgPath

	}

	@objc func tapped(_ touch: UIGestureRecognizer) {


		let touchPoint = touch.location(in: uiview)
		print(touchPoint)

//		let dynamicView = UIView(frame: CGRect(x: touchPoint.x, y: touchPoint.y, width: 100, height: 100))
//		dynamicView.center = CGPoint(x: touchPoint.x, y: touchPoint.y)
//		dynamicView.backgroundColor = UIColor.green
//		dynamicView.layer.cornerRadius = 25
//		dynamicView.layer.borderWidth = 2
//		self.uiview.addSubview(dynamicView)
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

	private func addLinePath(between point1: CGPoint, and point2: CGPoint) -> UIBezierPath {
		let linePath = UIBezierPath()
		linePath.move(to: point1)
		linePath.addLine(to: point2)
		return linePath
	}


}


//			let point11 = CGPoint(x: viewArray[i].bounds.midX, y: (viewArray[i].bounds.origin.y-viewArray[i].bounds.height))
//			let point22 = CGPoint(x: viewArray[i+1].bounds.midX, y: (viewArray[i+1].bounds.origin.y-viewArray[i+1].bounds.height))
