//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class InitialView : UIViewController {
    var titleLabel: UILabel!
    var titleText = "Approximating Pi in an exciting way"
    
    var continueButton: UIButton!
    
    override func loadView() {
        let view = UIView()
        view.frame = CGRect(x:0, y:0, width: 800, height: 600)
        view.backgroundColor = .white
        
        self.titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 600, height: 600))
        self.titleLabel.text = ""
        self.titleLabel.font = UIFont.systemFont(ofSize: 55, weight: .heavy)
        self.titleLabel.numberOfLines = 0
        
        timeTypePhrase(label: self.titleLabel, goal: self.titleText, interval: 0.05)
        
        self.continueButton = UIButton(type: .system)
        self.continueButton.setTitle("CONTINUE", for: .normal)
        self.continueButton.tintColor = .black
        self.continueButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        self.continueButton.center = view.center
        self.continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        view.addSubview(self.titleLabel)
        view.addSubview(self.continueButton)
        
        self.view = view
    }
}

func typePhrase(current: String, goal: String) -> String {
    return String(goal.prefix(current.count + 1))
}

func timeTypePhrase(label: UILabel, goal: String, interval: TimeInterval) -> Timer {
    return Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
        label.text = typePhrase(current: label.text!, goal: goal)
        if label.text!.count == goal.count {
            label.text = goal
            timer.invalidate()
        }
    }
}

let viewController = InitialView()
viewController.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = viewController
