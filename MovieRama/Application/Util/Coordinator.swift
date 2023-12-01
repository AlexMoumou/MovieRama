//
//  Coordinator.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
