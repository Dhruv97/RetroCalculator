//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Dhruv Upadhyay on 1/19/16.
//  Copyright © 2016 Dhruv Upadhyay. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var clearButton: UIButton!
    var buttonSound: AVAudioPlayer!
    
    @IBOutlet var outputLabel: UILabel!
    
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
       try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
            }

    @IBAction func numberPressed(button: UIButton) {
        
       playSound()
        
            runningNumber += "\(button.tag)"
        
            outputLabel.text = runningNumber
        
    }

    
    @IBAction func onDividePressed(sender: AnyObject) {
        
        processOperation(Operation.Divide)
        
    }
    
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        
        processOperation(Operation.Subtract)
        
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        
        processOperation(Operation.Add)
        
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        
        processOperation(currentOperation)
        
    }
    
    func processOperation(op: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            
            
            
            currentOperation = op
            
        } else {
            
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
    }
    
    func playSound() {
        
        if buttonSound.playing {
            
            buttonSound.stop()
            
        }
        
        buttonSound.play()
        
    }
    
    
   @IBAction func clearPressed(sender: AnyObject) {
        
        playSound()
         runningNumber = ""
         leftValStr = ""
         rightValStr = ""
         currentOperation = Operation.Empty
         result = ""
        outputLabel.text = result
        
    }
    
}

