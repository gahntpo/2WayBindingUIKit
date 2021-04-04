//
//  UIScrollView+Publisher.swift
//  DataFlowProject
//
//  Created by Karin Prater on 04.04.21.
//

import Foundation
import UIKit
import Combine


extension UIScrollView {
    
    func contentOffsetPublisher() -> AnyPublisher<CGPoint, Never> {
        
        self.publisher(for: \.contentOffset, options: .new)
            .eraseToAnyPublisher()
        
    }
    
}
