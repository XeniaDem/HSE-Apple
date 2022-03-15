//
//  CheckFieldManager.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 15.03.2022.
//

import UIKit
class CheckField {
    static let shared = CheckField()
    init() { }
    
    //isValid
    private func isValid(_ type: String, _ data: String) -> Bool {
        var dataRegEx = ""
        switch type {
        case "e":
            dataRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        default:
            dataRegEx = "(?=.*[A-Z0-9a-z]).{6,}"
        }
        let dataPred = NSPredicate(format:"SELF MATCHES %@", dataRegEx)
        return dataPred.evaluate(with: data)
    }
    
    //validField
    func validField(_ parentView: UIView, _ field: UITextField) -> Bool {
        let id = field.restorationIdentifier
        switch id {
        case "name":
            if field.text?.count ?? 0 < 3{
                validView(parentView, field, false)
                return false
            } else {
                validView(parentView, field, true)
                 return true
            }
        case "email":
            if isValid("e", field.text!) {
               validView(parentView, field, true)
                return true
            } else {
                validView(parentView, field, false)
                return false
            }
        case "password":
            if isValid("p", field.text!) {
                validView(parentView, field, true)
                return true
            } else {
                validView(parentView, field, false)
                return false
            }
        default:
            if field.text?.count ?? 0 < 2 {
                validView(parentView, field, false)
                return false
            } else {
                validView(parentView, field, true)
                 return true
            }
        }
    }
    
    //valid view
    private func validView(_ parentView: UIView, _ field: UITextField, _ valid: Bool) {
        if valid {
            field.backgroundColor = .tertiarySystemBackground
            parentView.backgroundColor = .tertiarySystemBackground

        } else {
            field.backgroundColor = #colorLiteral(red: 1, green: 0.2566739321, blue: 0.3427716792, alpha: 1)
            parentView.backgroundColor = #colorLiteral(red: 1, green: 0.2566739321, blue: 0.3427716792, alpha: 1)
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: parentView.center.x - 10, y:parentView.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: parentView.center.x + 10, y: parentView.center.y))
            parentView.layer.add(animation, forKey: "position")
        }
    }
}
