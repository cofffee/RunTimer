//
//  ViewController.swift
//  Run
//
//  Created by Kevin Remigio on 7/23/17.
//  Copyright © 2017 Kevin Remigio. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

class ViewController: UIViewController {
    
    var timeLabel: UILabel? = nil
    
    var minutes = 0
    var seconds = 0
    var milliSeconds = 0
    var hour = 0
    var timer: Timer? = nil
    
    var startStopButton: UIButton? = nil
    var pauseButton: UIButton? = nil
    
    var motivationLabel: UILabel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpView()
        

    }
    func setUpView() {
    
        let labelRect: CGRect = CGRect(x: 0, y: (view.frame.height / 2) - 25, width: view.frame.width, height: 50)
        timeLabel = UILabel(frame: labelRect)
        timeLabel?.textAlignment = .center
        timeLabel?.font = UIFont(name: "Helvetica", size: 40)
        updateLabel()
        view.addSubview(timeLabel!)
        
        let startStopButtonFrame = CGRect(x: ((view.frame.width / 2) - 30) + 30, y: (view.frame.height / 2) + 200, width: 60, height: 60)
        startStopButton = UIButton(frame: startStopButtonFrame)
        startStopButton?.setTitle("start", for: .normal)
        startStopButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        startStopButton?.setTitleColor(UIColor.blue, for: .normal)
        startStopButton?.layer.cornerRadius = startStopButtonFrame.width / 2
        startStopButton?.addTarget(self, action: (#selector(ViewController.toggle)), for: .touchUpInside)
        view.addSubview(startStopButton!)
        
        let pauseButtonFrame = CGRect(x: ((view.frame.width / 2) - 30) - 30, y: (view.frame.height / 2) + 200, width: 60, height: 60)
        pauseButton = UIButton(frame: pauseButtonFrame)
        pauseButton?.setTitle("pause", for: .normal)
        pauseButton?.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        pauseButton?.setTitleColor(UIColor.blue, for: .normal)
        pauseButton?.layer.cornerRadius = pauseButtonFrame.width / 2
        pauseButton?.addTarget(self, action: (#selector(ViewController.pauseTimer)), for: .touchUpInside)
        view.addSubview(pauseButton!)
        
        let motivationFrame: CGRect = CGRect(x: 0, y: 140, width: view.frame.width, height: 60)
        motivationLabel = UILabel(frame: motivationFrame)
        motivationLabel?.textAlignment = .center
        motivationLabel?.font = UIFont(name: "Helvetica", size: 40)
        motivationLabel?.text = "fuckin do it"
        motivationLabel?.isHidden = true
        view.addSubview(motivationLabel!)
    }
    func runView() {
        view.backgroundColor = getRandomColor()
        motivationLabel?.isHidden = false
        motivationLabel?.textColor = getRandomColor()
        
        startStopButton?.setTitleColor(getRandomColor(), for: .normal)
        pauseButton?.setTitleColor(getRandomColor(), for: .normal)
    }
    func unRunView() {
        view.backgroundColor = UIColor.white
        motivationLabel?.isHidden = true
        startStopButton?.setTitleColor(UIColor.blue, for: .normal)
        pauseButton?.setTitleColor(UIColor.blue, for: .normal)
//        startStopButton?.backgroundColor = UIColor.white
//        pauseButton?.backgroundColor = UIColor.white
    }
    func toggle() {
        if timer == nil {
            startTimer()
            startStopButton?.setTitle("stop", for: .normal)
        } else {
            stopTimer()
            startStopButton?.setTitle("start", for: .normal)
        }
    
    }
    func viewLogic(option: Int) {
        if minutes % 2 == 0 {
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
        
        viewLogic(option: 1)

    }
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateTimer(_:)), userInfo: nil, repeats: true)
        }
        
    }
    func stopTimer() {
        unRunView()
        endTimer()
        resetTime()
    }
    
    func pauseTimer() {
        startStopButton?.setTitle("start", for: .normal)
        endTimer()
        unRunView()
    }
    func resetTime() {
        minutes = 0
        seconds = 0
        milliSeconds = 0
        hour = 0
        updateLabel()
    }
    func endTimer() {
        timer?.invalidate()
        timer = nil
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

/*
 UIView.animate(withDuration: 3 / 2, delay: 0, options: [.autoreverse], animations: {() -> Void in
 
 let transform: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
 
 self.startStopButton?.transform = transform
 
 }, completion: {(finished: Bool) -> Void in
 let transform: CGAffineTransform = CGAffineTransform.identity
 self.startStopButton?.transform = transform
 })
 
 */
