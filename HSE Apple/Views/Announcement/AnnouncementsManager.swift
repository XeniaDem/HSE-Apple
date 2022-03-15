//
//  AnnouncementsManager.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 11.02.2022.
//

import Foundation
var announcements: [AnnouncementModel] = []


   // var announcements: [AnnouncementModel] = []
func addAnnouncement(announcement: AnnouncementModel) {
    announcements.append(announcement)
    //saveData()
}
    //удаление ученика
func removeAnnouncement(at index: Int) {
    announcements.remove(at: index)

}
func replaceAnnouncement(at index: Int, newAnnouncement: AnnouncementModel) {
    announcements[index] = newAnnouncement
}
    //сохранение данных

    //загрузка данных
