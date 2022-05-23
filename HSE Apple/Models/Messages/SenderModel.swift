//
//  SenderModel.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 10.03.2022.
//

import Foundation
import MessageKit
import InputBarAccessoryView


struct Sender : SenderType {
    var photoURL: String
    var senderId: String
    var displayName: String
    
}
