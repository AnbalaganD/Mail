//
//  SerachView.swift
//  Mail
//
//  Created by Anbalagan D on 20/08/21.
//

import SwiftUI

//struct SearchView: View {
//
//    var body: some View {
//        Text("Search View")
//    }
//}
//
//struct NavigationSearch: UIViewControllerRepresentable {
//    typealias UIViewControllerType = Wrapper
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: Context) -> Wrapper {
//        return Wrapper()
//    }
//
//    func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
//        uiViewController.view.backgroundColor = UIColor.red
//        uiViewController.searchController = context.coordinator.serachController
//    }
//
//    class Coordinator: NSObject {
//
//        let navigationSearch: NavigationSearch
//
//        let serachController: UISearchController
//
//        init(_ navigationSearch: NavigationSearch) {
//            self.navigationSearch = navigationSearch
//            self.serachController = UISearchController(searchResultsController: nil)
//            super.init()
//        }
//    }
//
//    class Wrapper: UIViewController {
//        var searchController: UISearchController? {
//            get {
//                self.navigationItem.searchController
//            }
//            set {
//                self.navigationItem.searchController = newValue
//            }
//        }
//    }
//}


import SwiftUI
import UIKit

struct NavigationSearch: UIViewControllerRepresentable {
    typealias UIViewControllerType = Wrapper
    
    func makeCoordinator() -> Coordinator {
        Coordinator(representable: self)
    }

    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper()
    }
    
    func updateUIViewController(_ wrapper: Wrapper, context: Context) {
        wrapper.searchController = context.coordinator.searchController
    }
    
    class Coordinator: NSObject {
        let representable: NavigationSearch
        
        let searchController: UISearchController
        
        init(representable: NavigationSearch) {
            self.representable = representable
            self.searchController = UISearchController(searchResultsController: nil)
            super.init()
        }
    }
    
    class Wrapper: UIViewController {
        var searchController: UISearchController? {
            get {
                parent?.navigationItem.searchController
            }
            set {
                parent?.navigationItem.searchController = newValue
            }
        }
    }
}
