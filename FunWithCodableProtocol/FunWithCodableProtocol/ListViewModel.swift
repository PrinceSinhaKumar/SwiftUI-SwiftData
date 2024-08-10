//
//  ListViewModel.swift
//  FunWithCodableProtocol
//
//  Created by  Prince Shrivastav on 10/08/24.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var listItem: [ListModel] = []
    
    @MainActor
    func fetchListData() async throws {
        do {
            if let jsonString = Bundle.main.path(forResource: "User", ofType: "json"),
               let jsonData = try String(contentsOfFile: jsonString).data(using: .utf8),
               let listData = try await parseJsonData(jsonData) {
                listItem = listData
                print(listData)
            } else {
                throw ErrorHandler.fileNotAvailable
            }
        } catch {
            throw error
        }
    }
    
    func parseJsonData(_ jsonData: Data) async throws -> [ListModel]? {
        do {
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let formater = DateFormatter()
            formater.dateFormat = "dd-MM-yyyy"
            decoder.dateDecodingStrategy = .formatted(formater)
            return try decoder.decode([ListModel].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}

enum ErrorHandler: Error {
    case fileNotAvailable
    case missingValue
    case error
    
    var message: String {
        switch self {
        case .fileNotAvailable:
            "File not avaible"
        case .missingValue:
            "Missing value"
        case .error:
            self.localizedDescription
        }
    }
}
