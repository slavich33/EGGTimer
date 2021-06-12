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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var doneTitle: UILabel!
    
    //    let softTime = 5
    //    let mediumTime = 7
    //    let hardTime = 12
    //Our Dictionary
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    //Play music
    var player = AVAudioPlayer()
    //Its our var for timer
    var secondsRemaining: Int = 0
    //We need to have Timer with var for changing it
    var timer = Timer()
    
    @IBAction func hardnesSelected(_ sender: UIButton) {
        
        //This action stops the AvAudioPlayer
        stopSound()
        //We need to make variable to be equal progress of our progressBar
        var progress = progressBar.progress
        //then we setProgress equal to 0...1
        progressBar.setProgress(0, animated: true)
        //Then we make constant equal sender button title!
        let hardness = sender.currentTitle!
        //We have image View with info type String, which we wanna show which button we choose
        doneTitle.text = hardness
        //Another constant which we use for taking data from our Dictionary!
        let result = eggTimes[hardness]!
        //We need to make it equal of Float type(cos of progressBar)
        progress = Float(result)
        //Switch progress back to Int for Showing seconds remaining with Int type
        secondsRemaining = Int(progress)
        //This stop our Timer whenever we type another button
        timer.invalidate()
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            
            if secondsRemaining > 0 {
                progressBar.setProgress(Float(secondsRemaining), animated: true)
                print("\(secondsRemaining) seconds remaining")
                doneTitle.text = "Untill your type of egg (\(hardness)) \(secondsRemaining) seconds remaining!"
                secondsRemaining -= 1
            } else {
                doneTitle.text = "Done!"
                playSound(soundName: "alarm_sound")
                Timer.invalidate() }
        }
        
        //        if hardness == "Soft" {
        //            print("Time for your egg \(softTime)" )
        //        } else if hardness == "Medium" {
        //            print("Time for your egg \(mediumTime)")
        //        } else if hardness == "Hard" {
        //                print("Time for your egg \(hardTime)" )
        //            }
    }
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    func stopSound() {
        player.stop()
    }
}
