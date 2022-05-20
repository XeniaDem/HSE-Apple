//
//  TaskManager.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 14.03.2022.
//

import Foundation
var tasks: [TaskModel] = []

func addTask(task: TaskModel) {
    tasks.append(task)
    //saveData()
}
    //удаление ученика
func removeTask(at index: Int) {
    tasks.remove(at: index)

}
func replaceTask(at index: Int, newTask: TaskModel) {
    tasks[index] = newTask
}
    //сохранение данных

    //загрузка данных

