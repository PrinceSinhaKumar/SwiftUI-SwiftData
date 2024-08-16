//
//  FactoryModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

enum ModelType {
    case video(url: URLs)
    case list(url: URLs)
}

protocol FactoryModel {
    func createListModel(type: ModelType) -> any ListModel
}

class FactoryModelImp: FactoryModel {
    func createListModel(type: ModelType) -> any ListModel {
        switch type {
        case .video(let url):
            VideoListModel(url: url)
        case .list(let url):
            PhotoListModel(url: url)
        }
    }
}
