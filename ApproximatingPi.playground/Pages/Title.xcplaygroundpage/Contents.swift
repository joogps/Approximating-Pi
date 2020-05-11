//: Welcome!
//: In this playground, you will go in a journey through the amazing world of Pi approximation.

//: [Next](@next)

import UIKit
import PlaygroundSupport

class InitialView: UIViewController {
    var titleLabel: UILabel!
    var titleText = "Approximating Pi using elastic collisions"
    
    var bottomBar: UIStackView!
    
    override func loadView() {
        let view = UIView()
        view.frame = CGRect(x:0, y:0, width: 800, height: 600)
        view.backgroundColor = .white
        
        self.titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 600, height: 600))
        self.titleLabel.text = ""
        self.titleLabel.font = UIFont.systemFont(ofSize: 55, weight: .heavy)
        self.titleLabel.numberOfLines = 0
        
        timeTypePhrase(label: self.titleLabel, goal: self.titleText, interval: 0.01) { () -> () in
            UIView.animate(withDuration: 1.0) {
                self.bottomBar.alpha = 1.0
            }
        }
        
        let continueButton = generateBottomBarButton(label: "CONTINUE")
        self.bottomBar = generateBottomBar(parentView: view, buttons: [continueButton])
        
        self.bottomBar.alpha = 0
        
        view.addSubview(self.titleLabel)
        view.addSubview(self.bottomBar)
        
        self.view = view
    }
}

func typePhrase(current: String, goal: String) -> String {
    return String(goal.prefix(current.count + 1))
}

func timeTypePhrase(label: UILabel, goal: String, interval: TimeInterval, callback: @escaping ()->()) -> Timer {
    return Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
        label.text = typePhrase(current: label.text!, goal: goal)
        label.setNeedsLayout()
        label.setNeedsDisplay()
        if label.text!.count == goal.count {
            label.text = goal
            callback()
            timer.invalidate()
        }
    }
}

func generateBottomBar(parentView: UIView, buttons: Array<UIButton>) -> UIStackView {
    let stackView = UIStackView()
    stackView.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.center = parentView.center
    stackView.center.y = parentView.frame.height-45
    for button in buttons {
        stackView.addArrangedSubview(button)
    }
    stackView.backgroundColor = .black
    return stackView
}

func generateBottomBarButton(label: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(label, for: .normal)
    button.tintColor = .black
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return button
}

let viewController = InitialView()
viewController.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = viewController
