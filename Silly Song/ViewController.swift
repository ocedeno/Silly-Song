//
//  ViewController.swift
//  Silly Song
//
//  Created by Octavio Cedeno on 2/22/17.
//  Copyright © 2017 Cedeno Enterprises, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //IBOutlets:
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var lyricsTextBox: UITextView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        userNameTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    }
    
    //IBActions:
    @IBAction func createSong()
    {
        
        guard (userNameTextField.text != "") else
        {
            return
        }
        
        lyricsTextBox.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: userNameTextField.text!)
        dismissKeyboard()
    }
    
    @IBAction func resetButton()
    {
        userNameTextField.text = ""
        lyricsTextBox.text = ""
    }
    
    func shortNameForName(name: String) -> String
    {
        let vowelCharacterSet = CharacterSet.init(charactersIn: "aeiouäöü")
        guard let nameRange = name.lowercased().rangeOfCharacter(from: vowelCharacterSet) else {
            print("There are no vowels.")
            return name
        }
        let vowelIndex = nameRange.lowerBound
        let range = name.substring(from: vowelIndex)
        
        return String(describing: range).lowercased()
    }
    
    let bananaFanaTemplate =
        [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"
        ].joined(separator: "\n")

    func lyricsForName(lyricsTemplate: String, fullName: String) -> String
    {
        let shortName = shortNameForName(name: fullName)
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        createSong()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetButton()
    }
    
    func dismissKeyboard()
    {
        userNameTextField.resignFirstResponder()
    }
    
}

