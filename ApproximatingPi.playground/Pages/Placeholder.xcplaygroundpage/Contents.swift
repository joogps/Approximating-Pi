//: ## What is Pi?
//: Before going any further, let's recap what Pi really is.
//: [Continue](@next)

import UIKit
import PlaygroundSupport

class ExampleView: UIViewController {
    var centerLabel: UILabel!
    var centerCircle: CAShapeLayer!
    
    override func loadView() {
        let view = UIView()
        view.frame = CGRect(x:0, y:0, width: 800, height: 600)
        view.backgroundColor = .white
        
        self.centerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        self.centerLabel.center = view.center
        self.centerLabel.text = ""
        self.centerLabel.font = UIFont.systemFont(ofSize: 55, weight: .heavy)
        self.centerLabel.textAlignment = .center
        
        let circlePath = UIBezierPath(
            arcCenter: view.center,
        radius: CGFloat(200),
        startAngle: CGFloat(0),
        endAngle: CGFloat(Double.pi*2),
            clockwise: true).reversing()
        
        self.centerCircle = CAShapeLayer()
        self.centerCircle.path = circlePath.cgPath
        self.centerCircle.fillColor = UIColor.clear.cgColor
        self.centerCircle.strokeColor = UIColor.black.cgColor
        self.centerCircle.lineWidth = 30
        self.centerCircle.lineCap = .round
        
        view.addSubview(self.centerLabel)
        view.layer.addSublayer(self.centerCircle)
        
        self.view = view
        
        let animations = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            animateCircle(circle: self.centerCircle, from: 0, to: 0.5, duration: 3, callback: { () -> () in
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    animateCircle(circle: self.centerCircle, from: 0.5, to: 1, duration: 3, callback: { () -> () in
                        self.centerLabel.text = "𝛑"
                    })
                }
                self.centerLabel.text = "½𝛑"
            })
            self.centerLabel.text = ""
        }
        
        animations.fire()
    }
}

func animateCircle(circle: CAShapeLayer, from: CGFloat, to: CGFloat, duration: CFTimeInterval, callback: @escaping () -> ()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock {
        callback()
    }
    circle.strokeEnd = to
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = from
    animation.toValue = to
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    circle.add(animation, forKey: "line")
    CATransaction.commit()
}

let exampleView = ExampleView()
exampleView.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = exampleView
