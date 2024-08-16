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

struct ListSection {
    var videos: VideoList?
    var photos: PhotoList?
}
class EntertenmentViewModel: ListViewModel {
    @Published var dataList: ListSection = ListSection()

    var model: FactoryModel
    
    init(model: FactoryModel) {
        self.model = model
    }
    
    @MainActor
    func fetchList(modelListType: ModelType) async throws {
        let listModel = model.createListModel(type: modelListType)
        switch modelListType {
        case .video:
            if let videListModel = listModel as? VideoListModel {
                do {
                    dataList.videos = try await videListModel.fetchListService()
                    print("Videos \n \(dataList)")
                } catch let error {
                    throw error
                }
            }
        case .list:
            if let photoListModel = listModel as? PhotoListModel {
                do {
                    dataList.photos = try await photoListModel.fetchListService()
                    print("photos \n \(dataList)")
                } catch let error {
                    throw error
                }
            }
        }
    }
    
}
