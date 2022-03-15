//
//  TaskModel.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import Foundation
struct TaskModel {


    var title: String?
    var text: String?
    var dateOfPublication: Date?
    var dateOfDeadline: Date?
    var groups: String?
    var isRead: Bool?
    var attachments: [URL]?
    
}
