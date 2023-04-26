//
//  ViewController.swift
//  progressView
//
//  Created by Mohan K on 09/12/22.
//

import UIKit
enum progressState{
    case Start
    case Running
    case Pause
    case Continue
    case Ended
    case rverse
}

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var btn: UIButton!
    
    var progressBarTimer: Timer!
    var progressState: progressState = .Start

    var progressValue:Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 1.0
        progressView.progressTintColor = UIColor.blue
        progressView.progressViewStyle = .bar
    }
      
   @IBAction func btnStart(_ sender: Any) {

       if progressState == .Ended || progressState == .Start{
           progressView.progress = 1.0
           startatimer()
           progressState = .Running
           btn.setTitle("Running", for: .normal)
       }else if progressState == .Running{
           progressBarTimer.invalidate()
           progressState = .Pause
           btn.setTitle("Pause", for: .normal)
       }else if progressState == .Pause{
           startatimer()
           progressState = .Continue
           btn.setTitle("Continue", for: .normal)
       }
   }

    
    func startatimer(){
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateProgressView), userInfo: nil, repeats: true)
    }

    @objc func updateProgressView(){

        let progress = progressView.progress - 0.1
        progressView.setProgress(progress , animated: true)
        if(progressView.progress == 0.0)
        {
            progressBarTimer.invalidate()
            btn.setTitle("End", for: .normal)
            progressState = .Ended
        }
//        else if progressState == .rverse{
//            startatimer()
//            progressState = .rverse
//            btn.setTitle("Rverse", for: .normal)
//        }
    }
}

