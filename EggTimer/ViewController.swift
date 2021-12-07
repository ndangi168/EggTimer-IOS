//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    //Connecting text
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //creating dictionary
    let eggTimes = ["Soft": 5, "Medium": 10, "Hard": 15]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    //connecting buttons
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        //Optional variable
        //var x: String? = nil
        //we add "?" to make it optional and assing it nil value
        //And to unwrap it we use "!" after the variable
        //x!
        
        //add .invalidate to remove timer from loop
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        
        //Reseting after clicking different button
        titleLable.text = hardness
        
        //adding functions to our timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        //example functionality
        if secondPassed < totalTime {
            secondPassed += 1
            
            let precentageProgress = Float(secondPassed) / Float(totalTime)
            progressBar.progress = precentageProgress
        }
        else{
            //changiing text after couuntdown ends
            titleLable.text = "Done!"
            //play sound
            playSound(soundname: "alarm_sound")
            timer.invalidate()
            
            //Adding delay
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
                //changing text after delay
                self.titleLable.text = "How do you like your eggs?"
                //changing progress to 0 after completion
                self.progressBar.progress = 0.0
                //changing secondPassed to 0 after completion
                self.secondPassed = 0
            }
        }
    }
    
    func playSound(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
