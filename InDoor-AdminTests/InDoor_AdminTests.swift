//
//  InDoor_AdminTests.swift
//  InDoor-AdminTests
//
//  Created by Ahmed on 23/06/2023.
//

import XCTest
@testable import InDoor_Admin

final class InDoor_AdminTests: XCTestCase {

    var network: ApiService!
    var fakeNetwork: ApiService!
    var homeViewModel: HomeViewModel!
    var collectionProductsViewModel: CollectionProductsViewModel!
    
    override func setUpWithError() throws {
        network = ApiHandler()
        fakeNetwork = FakeNetwork()
        homeViewModel = HomeViewModel(network: fakeNetwork)
        collectionProductsViewModel = CollectionProductsViewModel(network: fakeNetwork)
    }

    override func tearDownWithError() throws {
        network = nil
        fakeNetwork = nil
        homeViewModel = nil
        collectionProductsViewModel = nil
    }

    func testRetrieveBrandsFromApi(){
        let myEexpectaion = expectation(description: "Waiting for Api Response")
        let url = "https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/smart_collections.json"
        network.handleProduct(method: .get, parameters: [:], url: url) { (allBrands:RootClass?) in
            guard let brandContainer = allBrands else {
                XCTFail("response came back nil")
                return
            }
            XCTAssertNotNil(brandContainer,"Network Responded With nil")
            XCTAssertTrue(brandContainer.smartCollections!.count>0)
            XCTAssertFalse(brandContainer.smartCollections?[0].id == nil)
            myEexpectaion.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testHomeViewModelDataRetrieval(){
        homeViewModel.getAvailableBrands {(brands) in
            XCTAssertNotNil(brands,"Network Responded With nil")
            XCTAssertTrue(brands[0].id == 1)
        }
    }
    
    func testCollectionProductsDataRetrieval(){
        collectionProductsViewModel.getPrdouctsOfSpecificBrand(brandID: "") { products in
            XCTAssertNotNil(products,"Network Responded With nil")
            XCTAssertTrue(products[0].title == "ADIDAS")
        }
    }

}
