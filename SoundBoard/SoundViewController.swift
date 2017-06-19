//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by vux on 19/6/17.
//  Copyright © 2017 crypticmantra. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    func setupRecorder() {
        
        do {
            
            // create audio session
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.overrideOutputAudioPort(.speaker)
            try audioSession.setActive(true)
            
            // create url
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("----> " + audioURL!.absoluteString)
            
            // create settings
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func recordButtonAction(_ sender: Any) {
        if audioRecorder!.isRecording {
            // stop the recording
            audioRecorder!.stop()
            // change button title to record
            recordButton.setTitle("Record",for: .normal)
            playButton.isEnabled = true
            addButton.isEnabled = true
        } else {
            // star the recording
            audioRecorder!.record()
            // change button title to Stop
            recordButton.setTitle("Stop",for: .normal)
            playButton.isEnabled = false
            addButton.isEnabled = false
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {
            print("Something wrong playing audio")
        }
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        // create core data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // create object
        let sound = Sound(context:context)
        sound.name = nameTextField.text
        sound.audio = NSData(contentsOf: audioURL!) as! Data
        
        // save
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // go back
        navigationController!.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
