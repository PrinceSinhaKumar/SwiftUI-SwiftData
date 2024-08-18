//
//  EntertenmentViewModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation
protocol ListViewModel: ObservableObject {
    var model: FactoryModel { get set }
}

class EntertenmentViewModel: ListViewModel {
    
    var model: FactoryModel
    
    init(model: FactoryModel) {
        self.model = model
    }
    
    @MainActor
    func fetchList(modelListType: ModelType) async throws -> Decodable {
        let listModel = model.createListModel(type: modelListType)
        switch modelListType {
        case .video:
            if let videListModel = listModel as? VideoListModel {
                do {
                    return try await videListModel.fetchListService()
                } catch let error {
                    throw error
                }
            }
        case .list:
            if let photoListModel = listModel as? PhotoListModel {
                do {
                    return try await photoListModel.fetchListService()
                } catch let error {
                    throw error
                }
            }
        }
        throw ErrorHandler.InvaildeResponse
    }
    
}
