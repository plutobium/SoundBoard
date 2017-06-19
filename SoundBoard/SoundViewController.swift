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
    
    func setupRecorder() {
        
        do {
            
            // create audio session
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.overrideOutputAudioPort(.speaker)
            try audioSession.setActive(true)
            
            // create settings
            
            
            // create url
            audioRecorder = try AVAudioRecorder(url: <#T##URL#>, settings: <#T##[String : Any]#>)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func recordButtonAction(_ sender: Any) {
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
