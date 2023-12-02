//
//  XibInstantiable.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import UIKit

public protocol XibInstantiable: NSObjectProtocol {
    static var defaultFileName: String { get }
}

public extension XibInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return String(describing: Self.self)
    }
    
    init() {
        self.init(nibName: Self.defaultFileName, bundle: Bundle.main)
    }
    
}

public protocol XibInstantiableCell: NSObjectProtocol {
    static var reuseIdentifier: String { get }
    static var cellHeight: CGFloat { get }
    static var nib: UINib { get }
}

public extension XibInstantiableCell where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: String(describing: Self.self), bundle: nil)
    }

}
