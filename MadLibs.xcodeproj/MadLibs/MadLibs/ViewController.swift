//
//  ViewController.swift
//  MadLibs
//
//  Created by Laureane Clark on 8/12/17.
//  Copyright © 2017 Laureane Clark. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var pastTenseVerbTextField: NSTextField!
    @IBOutlet weak var singularNounCombo: NSComboBox!
    @IBOutlet weak var pluralNounPopup: NSPopUpButton!
    @IBOutlet var phraseTextView: NSTextView!
    @IBOutlet weak var amountLabel: NSTextField!
    @IBOutlet weak var amountSlider: NSSliderCell!
    @IBOutlet weak var datePicker: NSDatePicker!
    @IBOutlet weak var rwDevConRadioButton: NSButton!
    @IBOutlet weak var threeSixtyRadioButton: NSButton!
    @IBOutlet weak var wwdcRadioButton: NSButton!
    @IBOutlet weak var yellCheck: NSButton!
    @IBOutlet weak var voiceSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var resultTextField: NSTextField!
    @IBOutlet weak var imageView: NSImageView!

    
    fileprivate enum VoiceRate: Int {
        case slow
        case normal
        case fast
        
        var speed: Float {
            switch self {
            case .slow:
                return 60
            case .normal:
                return 175
            case .fast:
                return 360
            }
        }
    }
    
    fileprivate func readSentance(_ sentance: String, rate: VoiceRate ) {
        synth.rate = rate.speed
        synth.stopSpeaking()
        synth.startSpeaking(sentance)
    }
    
    fileprivate let synth = NSSpeechSynthesizer()
    
    fileprivate let singularNouns = [ "dog", "muppet", "pirate", "dev" ]
    fileprivate let pluralNouns = ["tacos", "rainbows", "iphones", "gold coins"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singularNounCombo.removeAllItems()
        singularNounCombo.addItems(withObjectValues: singularNouns)
        singularNounCombo.selectItem(at: singularNouns.count-1)
        
        
        pluralNounPopup.removeAllItems()
        pluralNounPopup.addItems(withTitles: pluralNouns)
        pluralNounPopup.selectItem(at: 0)
        
        //slider sets position
        sliderChanged(self)
        
        //date gets set
        datePicker.dateValue = Date()
        
        // Sets radio group default button
        rwDevConRadioButton.state = NSOnState
        
        //Sets Check button to off
        yellCheck.state = NSOffState
        
        //Set the segmented control initial selection
        voiceSegmentedControl.selectedSegment = 1
        
        
        pastTenseVerbTextField.stringValue = "ate"
        
        phraseTextView.string = "We Coding Mac Apps!!!"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func goButtonClicked(_ sender: Any) {
        
        let pastTenseVerb = pastTenseVerbTextField.stringValue
        
        let  singularNoun = singularNounCombo.stringValue
        
        let amount = amountSlider.integerValue
        
        let pluralNoun = pluralNouns[pluralNounPopup.indexOfSelectedItem]
        
        let phrase = phraseTextView.string ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let date = dateFormatter.string(from: datePicker.dateValue)
        
        var voice = "said"
        if yellCheck.state == NSOnState {
            voice = "yelled"
        }
        
        let sentance = "On \(date), at \(selectedPlace) a \(singularNoun) \(pastTenseVerb) \(amount) \(pluralNoun) and \(voice), \(phrase)"
        
        resultTextField.stringValue = sentance
        imageView.image = NSImage(named: "face")
        
        let selectedSegment = voiceSegmentedControl.selectedSegment
        let voiceRate = VoiceRate(rawValue: selectedSegment) ?? .normal
        readSentance(sentance, rate: voiceRate)
        
        
        
            }
    
    @IBAction func sliderChanged(_ sender: Any) {
        
        let amount = amountSlider.integerValue
        amountLabel.stringValue = "Amount: [\(amount)]"
    }
    
    @IBAction func radioButtonChanged(_ sender: AnyObject) {
        
    }
    
    fileprivate var selectedPlace: String {
        var place = "home"
        if rwDevConRadioButton.state == NSOnState {
            place = "RWDevCon"
        }
        else if threeSixtyRadioButton.state == NSOnState {
            place = "360iDev"
        }
        else if wwdcRadioButton.state == NSOnState {
            place = "WwDC"
        }
        return place
    }

}

