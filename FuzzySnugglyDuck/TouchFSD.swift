//
//  TouchFSD.swift
//  FuzzySnugglyDuck
//
//  Created by Charles Dardaman on 5/16/19.
//  Copyright © 2019 Charles Dardaman. All rights reserved.
//

import Cocoa
import AVFoundation
import Foundation
import AppKit

class TouchFSD: NSWindowController {
    
    var audio_player: AVAudioPlayer?
    var mvString = "🦆"
    let lane = NSView()
    
    
    let  theme_music = URL(fileURLWithPath: Bundle.main.path(forResource: "TheDuckSong", ofType: "mp3")!)
    
    let duck_icon = URL(fileURLWithPath: Bundle.main.path(forResource: "icon", ofType: "png")!)
    
    @IBOutlet weak var magic_bar: NSTouchBarItem!
    @IBOutlet weak var full_bar: NSView!
    @IBOutlet weak var start_button: NSButtonCell!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        do {
            
            try audio_player = AVAudioPlayer(contentsOf: theme_music)
            audio_player?.numberOfLoops = -1
            audio_player?.prepareToPlay()
            
        }catch{}
        
        lane.frame = CGRect(x: 0, y: 0, width: full_bar.frame.width*2, height: full_bar.frame.height)
        lane.layer?.position = CGPoint(x: 0, y: 0)
        
        full_bar.addSubview(lane)
        
        for x in 0...16 {
            //lane.addSubview(duck_line(x: x * 100))
            lane.addSubview(duck_coin_line(x: x * 100))
        }
        
    }
    
    
    @IBAction func start_theme_music(_ sender: NSButtonCell) {
        if start_button.title == "Start Magic" {
            audio_player?.play()
            start_button.title = "Stop"
            start_ducks()
        } else{
            start_button.title = "Start Magic"
            audio_player?.pause()
        }

        
    }
    
    func duck_coin_line(x : Int) -> NSView {
        let ducks = NSTextView(frame: NSRect(x: x, y: 0, width: 30, height: 30))
        ducks.string = mvString
        ducks.drawsBackground = false
        ducks.isEditable = false
        ducks.isSelectable = false
        ducks.font = NSFont.systemFont(ofSize: 20)
        return ducks
    }
    
    func duck_line(x : Int) -> NSView {
        let ducks = NSTextView(frame: NSRect(x: x, y: 0, width: 30, height: 30))
        ducks.string = mvString
        ducks.drawsBackground = false
        ducks.isEditable = false
        ducks.isSelectable = false
        ducks.font = NSFont.systemFont(ofSize: 20)
        return ducks
    }
    
    func start_ducks() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.repeatCount = .infinity
        animation.duration = 8
        animation.fromValue = lane.layer?.position
        animation.toValue = NSValue(point: NSPoint(x: -full_bar.frame.width, y: 0))
        lane.layer?.add(animation, forKey: "position")
    }
    
    

}
