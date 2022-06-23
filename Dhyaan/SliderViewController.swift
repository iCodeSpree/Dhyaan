//
//  SliderViewController.swift
//  Dhyaan
//
//  Created by Shreya Zala on 6/19/22.
//

import AVFoundation
import UIKit

class SliderViewController: UIViewController {
    
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var gongIntervalSlider: UISlider!
    @IBOutlet weak var gongIntervalLbl: UILabel!
    @IBOutlet weak var meditateBtn: UITabBarItem!
    @IBOutlet weak var startSessionBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    
    var sliderValue = 0
    var gongSoundPlayer: AVAudioPlayer?
    var isSessionInactive: Bool = true
    var timer: Timer?
    var isTimerStarted = false
    var time = Int()
    //var initialValue = 0
    var gongValue = 0
    var gongFlag = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
        timerLblConfig()
        timerLbl.isHidden = true
        gongIntervalLbl.isHidden = true
    }
    
    @IBAction func durationSliderAct(_ sender: UISlider) {
        durationSliderConfig()
        timerLbl.isHidden = false
        if sender.value == 0 {
            durationLabel.text = "60"
            sliderValue = 60
            time = 60 * 60
            gongIntervalSlider.isEnabled = false
            gongIntervalLbl.isHidden = true
            timerLbl.isHidden = true
        } else {
            let currentValue = Int(sender.value)
            durationLabel.text = "\(currentValue)"
            if currentValue != 0 {
                timerLbl.text = "\(currentValue):00"
            }
            if currentValue == 60 {
                timerLbl.text = "1:00:00"
            }
            sliderValue = currentValue
            time = currentValue * 60
            sliderValue = currentValue > 30 ? 30 : (currentValue > 15 && currentValue < 30) ? 15 : currentValue
            gongIntervalSlider.isEnabled = true
            //initialValue = currentValue
        }
        
    }
    
    @IBAction func gongIntervalAct(_ sender: UISlider) {
        gongIntervalSliderConfig()
        gongIntervalLbl.isHidden = false
        if sender.value == 0 {
            gongIntervalLbl.text = "\(sliderValue)"
        } else {
            let currentValue = Int(sender.value)
            gongIntervalLbl.text = "\(currentValue)"
            gongValue = currentValue
            gongFlag = 1
        }
    }
    
    @IBAction func startSessionBtnTapped(_ sender: Any) {
        if isSessionInactive {
            if timerLbl.isHidden == false {
                startSessionBtn.setImage(UIImage(named: "stopButton"), for: .normal)
                isSessionInactive = false
                startTimer()
                gongSoundPlay()
            }
        } else {
            stopTimer()
            startSessionBtn.setImage(UIImage(named: "startButton"), for: .normal)
            isSessionInactive = true
            timerLbl.text = "00:00"
            resetSettings()
            gongSoundStop()
        }
    }
    
    
    func tabBarConfig() {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        tabBar.barTintColor = .black
        tabBar.tintColor = #colorLiteral(red: 0.6857369542, green: 0.8708372712, blue: 0.2421270013, alpha: 1)
    }
    
    func durationSliderConfig() {
        durationSlider.minimumValue = 0
        durationSlider.maximumValue = 60
    }
    
    func gongIntervalSliderConfig() {
        gongIntervalSlider.minimumValue = 0
        gongIntervalSlider.maximumValue = Float(sliderValue)
    }
    
    func gongSoundPlay() {
        let urlString = Bundle.main.path(forResource: "gongSound", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else { return }
            
            gongSoundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = gongSoundPlayer else { return }
            
            player.play()
            
        } catch {
            print("something went wrong")
        }
    }
    
    func gongSoundStop() {
        let urlString = Bundle.main.path(forResource: "gongSound", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else { return }
            
            gongSoundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = gongSoundPlayer else { return }
            
            let btnImage = startSessionBtn.imageView?.image
            if btnImage == UIImage(named: "stopButton") && gongFlag == 0 {
                player.stop()
            }
        } catch {
            print("something went wrong")
        }
    }
    
    func timerLblConfig() {
        timerLbl.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
   @objc func updateTimer(){
       if time > 0 {
           time -= 1
           timerLbl.text = formatTime()
           if gongValue <= 9 && timerLbl.text == "0\(gongValue):00" {
               gongSoundPlay()
           } else if gongValue > 9 && timerLbl.text == "\(gongValue):00" {
               gongSoundPlay()
           }
           if timerLbl.text == "00:00" {
               resetSettings()
               gongSoundPlay()
               startSessionBtn.setImage(UIImage(named: "startButton"), for: .normal)
               timer?.invalidate()
               timer = nil
           }
       }
    }
    
    func resetSettings() {
        timerLbl.isHidden = true
        durationSlider.setValue(0.0, animated: true)
        gongIntervalSlider.setValue(0.0, animated: true)
        durationLabel.text = "60"
        gongIntervalLbl.isHidden = true
    }
    
    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
