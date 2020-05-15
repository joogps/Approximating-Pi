//: ## Ahoy!
//: #### In this playground, you will go in a journey through the amazing world of Pi approximation. Come with me!
//: [Continue](@next)

import UIKit
import PlaygroundSupport

class TitleView: UIViewController {
    var titleLabel: UILabel!
    var titleText = "Approximating Pi in an exciting way"
    
    var continueButton: UIButton!
    
    override func loadView() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 800, height: 600)
        view.backgroundColor = .white
        
        self.titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 600, height: 600))
        self.titleLabel.text = ""
        self.titleLabel.font = UIFont.systemFont(ofSize: 55, weight: .heavy)
        self.titleLabel.numberOfLines = 0
        
        timeTypePhrase(label: self.titleLabel, goal: self.titleText, interval: 0.01)
        
        view.addSubview(self.titleLabel)
        
        self.view = view
    }
}

func typePhrase(current: String, goal: String) -> String {
    return String(goal.prefix(current.count + 1))
}

func timeTypePhrase(label: UILabel, goal: String, interval: TimeInterval) -> Timer {
    return Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
        label.text = typePhrase(current: label.text!, goal: goal)
        label.setNeedsLayout()
        label.setNeedsDisplay()
        if label.text!.count == goal.count {
            label.text = goal
            timer.invalidate()
        }
    }
}

let titleView = TitleView()
titleView.preferredContentSize = CGSize(width: 800, height: 600)
PlaygroundPage.current.liveView = titleView
