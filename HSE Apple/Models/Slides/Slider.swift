//
//  Slider.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 08.02.2022.
//

import Foundation
class Slider {
    func getSlides() -> [Slides] {
        var slides: [Slides] = []
        let slide1 = Slides(id: 1, description: "Легко общайтесь с людьми, которые разделяют ваши интересы \nОтвечайте на вопросы и задавайте свои ", image: #imageLiteral(resourceName: "slide1"))
        let slide2 = Slides(id: 2, description: "Узнавайте первыми о новых \nзаданиях и объявлениях, а также обсуждайте их", image: #imageLiteral(resourceName: "slide3"))
        let slide3 = Slides(id: 3, description: "Зарегистрируйтесь или войдите в аккаунт для начала продуктивной работы", image: #imageLiteral(resourceName: "slide2"))
        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        return slides 
    }
}
