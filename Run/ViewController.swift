//
//  ViewController.swift
//  Run
//
//  Created by Kevin Remigio on 7/23/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var timeLabel: UILabel? = nil
    
    var minutes = 0
    var seconds = 0
    var milliSeconds = 0
    var hour = 0
    var timer: Timer? = nil
    
    var startStopButton: UIButton? = nil
    var pauseButton: UIButton? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let labelRect: CGRect = CGRect(x: 0, y: (view.frame.height / 2) - 25, width: view.frame.width, height: 50)
        timeLabel = UILabel(frame: labelRect)
        timeLabel?.textAlignment = .center
        timeLabel?.font = UIFont(name: "Helvetica", size: 40)
        updateLabel()
        view.addSubview(timeLabel!)
        
        
        let startStopButtonFrame = CGRect(x: ((view.frame.width / 2) - 30) + 30, y: (view.frame.height / 2) + 200, width: 60, height: 60)
        startStopButton = UIButton(frame: startStopButtonFrame)
        startStopButton?.setTitle("Start", for: .normal)
        startStopButton?.setTitleColor(UIColor.blue, for: .normal)
        startStopButton?.addTarget(self, action: (#selector(ViewController.toggle)), for: .touchUpInside)
        view.addSubview(startStopButton!)
        
        let pauseButtonFrame = CGRect(x: ((view.frame.width / 2) - 30) - 30, y: (view.frame.height / 2) + 200, width: 60, height: 60)
        pauseButton = UIButton(frame: pauseButtonFrame)
        pauseButton?.setTitle("Pause", for: .normal)
        pauseButton?.setTitleColor(UIColor.blue, for: .normal)
        pauseButton?.addTarget(self, action: (#selector(ViewController.pauseTimer)), for: .touchUpInside)
        view.addSubview(pauseButton!)
        startTimer()
    }
    func runView() {
        view.backgroundColor = getRandomColor()
    }
    func unRunView() {
        view.backgroundColor = UIColor.white
    }
    func toggle() {
        if timer == nil {
            startTimer()
            startStopButton?.setTitle("Stop", for: .normal)
        } else {
            stopTimer()
            startStopButton?.setTitle("Start", for: .normal)
        }
    
    }
    func viewLogic() {
        if minutes % 2 == 1 {
            runView()
        } else {
            unRunView()
        }
    }
    func updateTimer(_ sender: AnyObject) {
        
        // do math here 
        //hours
        //minutes 60 = 1 hour
        //seconds 60 = 1 minute
        //milliseconds 1000 = 1 sec

        milliSeconds += 1

        
        
        if minutes == 60 {
            stopTimer()
        } else if seconds == 60 {
            minutes += 1
            updateLabel()
            seconds = seconds % seconds
        }
        else if milliSeconds >= 99 {
            seconds += 1
            updateLabel()
            milliSeconds = milliSeconds % milliSeconds
            
        } else {
            updateLabel()
        }
        
        viewLogic()

    }
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateTimer(_:)), userInfo: nil, repeats: true)
        }
        
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        resetTime()
    }
    
    func pauseTimer() {
        startStopButton?.setTitle("Start", for: .normal)
        timer?.invalidate()
        timer = nil
    }
    func resetTime() {
        minutes = 0
        seconds = 0
        milliSeconds = 0
        hour = 0
        updateLabel()
    }
    func updateLabel() {
        timeLabel?.text = "\(String.twoDigInts(theInt: minutes)):\(String.twoDigInts(theInt: seconds)):\(String.twoDigInts(theInt: milliSeconds))"
    }
    func getRandomColor() -> UIColor {
        let index = arc4random() % 4
        
        switch index {
        case 0:
            return UIColor(red: 242/255, green: 122/255, blue: 85/255, alpha: 1.0)
        case 1:
            return UIColor(red: 242/255, green: 226/255, blue: 151/255, alpha: 1.0)
        case 2:
            return UIColor(red: 137/255, green: 181/255, blue: 218/255, alpha: 1.0)
        case 3:
            return UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        default:
            print("How did you get here")
            return UIColor(red: 97/255, green: 213/255, blue: 212/255, alpha: 1.0)
        }
    }
}

extension String {

    static func twoDigInts(theInt: Int) -> String {
        let twoDigs: String = String(format: "%02d", theInt)
        return twoDigs
    }
}
