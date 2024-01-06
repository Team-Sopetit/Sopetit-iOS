//
//  UITableViewRegisterable.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

protocol UITableViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
    static func dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> Self
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forCellReuseIdentifier: Self.className)
        } else {
            target.register(self, forCellReuseIdentifier: Self.className)
        }
    }
    
    static func dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.className, for: indexPath) as? Self else { fatalError()}
        return cell
    }
}

protocol UITableViewHeaderFooterRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
    static func dequeueReusableHeaderFooterView(tableView: UITableView) -> Self
}

extension UITableViewHeaderFooterRegisterable where Self: UITableViewHeaderFooterView {
    static func register(target: UITableView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forHeaderFooterViewReuseIdentifier: Self.className)
        } else {
            target.register(self, forHeaderFooterViewReuseIdentifier: Self.className)
        }
    }
    
    static func dequeueReusableHeaderFooterView(tableView: UITableView) -> Self {
        guard let headerfooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.className) as? Self else { fatalError()}
        return headerfooterView
    }
}
