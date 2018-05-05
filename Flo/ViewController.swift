//
//  ViewController.swift
//  Flo
//
//  Created by Pavlo Novak on 4/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var medalView: MedalView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var isGraphViewShowing = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in })
        counterLabel.text = String(counterView.counter)
        setupGraphDisplay()
        checkTotal()
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = stackView.arrangedSubviews.count - 1
        // replace date with today's actual date
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        // redraw graph
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        // calculate average from graphPoints
        let average = graphView.graphPoints.reduce(0,+) / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        // Setup date formatter & calendar
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        // setup name labels with correct days' name
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today), let label = stackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }
    
    func checkTotal() {
        
        if counterView.counter >= 8 {
            medalView.showMedal(show: true)
        } else {
            medalView.showMedal(show: false)
        }
    }
    
    @IBAction func pushButtonPressed(_ button: PushButton) {
        
        if button.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(nil)
        }
        checkTotal()
    }
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        
        if isGraphViewShowing {
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }

    @IBAction func registerLocal(sender: AnyObject) {
        
        let content = UNMutableNotificationContent()
        content.title = "Flo"
        content.subtitle = "Advice"
        content.body = "Don't forget to drink up to 8 glasses of water daily."
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

