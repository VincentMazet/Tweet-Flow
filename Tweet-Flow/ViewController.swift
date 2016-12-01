//
//  ViewController.swift
//  Tweet-Flow
//
//  Created by iem on 01/12/2016.
//  Copyright © 2016 iem. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var socialNetwork: UILabel!
    
    var pickerData = [
        ["Make m'rica gr8 again","Swift c krô b1","Appeule","watermelon"]
        ,["( ͡° ͜ʖ ͡°)","(⌐■_■)","ᗒ ͟ʖᗕ","^‿^"]]
    
    var firstRowData = ""
    var secondRowData = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        firstRowData = self.pickerData[0][0]
        secondRowData = self.pickerData[1][0]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            firstRowData = pickerData[0][row]
            return firstRowData
        } else if component == 1 {
            secondRowData = pickerData[1][row]
            return secondRowData
        }else {
            return nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @IBAction func changeSocialNetwork(_ sender: UISwitch) {
        if socialSwitch.isOn {
            view.backgroundColor = UIColorFromHex(rgbValue: 0x85172238,alpha: 3.0)
            socialNetwork.text = "Facebook"
        }else{
            view.backgroundColor = UIColorFromHex(rgbValue: 0x45989152,alpha: 3.0)
            socialNetwork.text = "Twitter"
        }
    }
    
    @IBAction func closeKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func btnAction(_ sender: AnyObject) {
        var tweet = self.textField.text
        
        if tweet == nil || tweet == "" {
            tweet = firstRowData + " " + secondRowData
        }
        
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            vc.setInitialText(tweet)
            present(vc, animated: true)
        }
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
