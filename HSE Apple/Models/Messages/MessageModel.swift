//
//  MessageModel.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 10.03.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
