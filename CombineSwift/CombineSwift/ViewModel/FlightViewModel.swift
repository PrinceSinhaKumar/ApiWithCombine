//
//  PhotoViewModel.swift
//  CombineSwift
//
//  Created by  Prince Shrivastav on 22/08/24.
//

import Foundation
import Combine

class FlightViewModel: ObservableObject {
    
    @Published var flightList: PhotoList?
    @Published var error: APIError?
    @Published var progress: Progress?
    
    private var cancellables = Set<AnyCancellable>()

    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkManager()) {
            self.networkService = networkService
    }
    
    func fetchRequest() {
        progress = .start
        networkService.request(HomeEndPoint.photoList, type: PhotoList.self, parameters: nil)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.progress = .stop
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: {[weak self] value in
                self?.flightList = value
                print(value)
            }
            .store(in: &cancellables)

    }
}

class ConcurrentAPIViewModel: ObservableObject {
    
    @Published var productList: [Product] = []
    @Published var albumList: [Album] = []
    @Published var error: APIError?
    @Published var progress: Progress?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkManager()) {
            self.networkService = networkService
    }
    
    func fetchConcurrentService() {
        progress = .start
        Publishers.Zip(
            networkService.request(HomeEndPoint.productList, type: [Product].self, parameters: nil),
            networkService.request(HomeEndPoint.album, type: [Album].self, parameters: nil)
        )
//        Publishers.CombineLatest(
//            networkService.request(HomeEndPoint.product, type: [Product].self, parameters: nil),
//            networkService.request(HomeEndPoint.album, type: [Album].self, parameters: nil)
//        )
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.progress = .stop
            case .failure(let error):
                self?.error = error
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] (productList, albumList) in
            self?.productList = productList
            self?.albumList = albumList
            print("Product List \n \(productList) \n\n Album list \n \(albumList)")
        }
        .store(in: &cancellables)

    }
    
    func apiAfterCompletionOfMultipleApi() {
        Publishers.CombineLatest(
            networkService.request(HomeEndPoint.productList, type: [Product].self, parameters: nil),
            networkService.request(HomeEndPoint.album, type: [Album].self, parameters: nil)
        )
        .flatMap { [weak self] (productList, albumList)  -> AnyPublisher<Product, APIError> in
            self?.productList = productList
            self?.albumList = albumList
            print("Product List \n \(productList) \n\n Album list \n \(albumList.first)")
            return self?.networkService.request(HomeEndPoint.product(id: productList.randomElement()?.id ?? ""), type: Product.self, parameters: nil) ?? Empty().eraseToAnyPublisher()
        }
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                self?.progress = .stop
            case .failure(let error):
                self?.error = error
                print(error.localizedDescription)
            }
        } receiveValue: { product in
            print("\nProduct \n \(product)")
        }
        .store(in: &cancellables)
    }
}
