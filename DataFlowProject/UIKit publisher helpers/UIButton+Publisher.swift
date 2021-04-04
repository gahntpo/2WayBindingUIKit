//
//  UIButton+Publisher.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

import Foundation
import UIKit
import Combine

extension UIButton {
    
    func tapPublisher() -> AnyPublisher<Void, Never> {
        self.publisher(for: .touchUpInside)
            .map({ _ in
                return
            })
            .eraseToAnyPublisher()
    }
    
}
