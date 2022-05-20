//
//  ViewAnswerViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 20.05.2022.
//

import Foundation
import UIKit

class ViewAnswerViewController : UIViewController, UITextFieldDelegate{
    @IBOutlet weak var linkTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        linkTextField.delegate = self
        linkTextField.inputView = UIView(frame: CGRect.zero )
    
    }
    @IBAction func doneButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
func textFieldShouldBeginEditing(_ linkTextField: UITextField) -> Bool {
    return false
}

