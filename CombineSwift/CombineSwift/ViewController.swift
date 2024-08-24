//
//  ViewController.swift
//  CombineSwift
//
//  Created by  Prince Shrivastav on 22/08/24.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: FlightViewModel = FlightViewModel()
    var concurrentViewModel: ConcurrentAPIViewModel = ConcurrentAPIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetailAfterProductList()
    }

    func callAPi() {
        viewModel.fetchRequest()
    }
    
    func productAndAlbumList() {
        concurrentViewModel.fetchConcurrentService()
    }
    
    func getProductDetailAfterProductList() {
        concurrentViewModel.apiAfterCompletionOfMultipleApi()
    }
    
}

