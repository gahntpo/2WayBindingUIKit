//
//  UISlider+Publisher.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

import Foundation
import Combine
import UIKit

extension UISlider {
    
    func valuePublisher() -> AnyPublisher<Float, Never> {
        self.publisher(for: .valueChanged)
            .compactMap { ($0 as? UISlider)?.value }
            .eraseToAnyPublisher()
    }
    
    func createBinding<T: BinaryFloatingPoint>(with subject: CurrentValueSubject<T, Never>, storeIn subscriptions: inout Set<AnyCancellable>) {
        
        subject
            .map({ Float($0) })
            .sink { [weak self] (value) in
            if self?.value != value {
                self?.value = value
            }
        }.store(in: &subscriptions)
        
        self.valuePublisher()
            .map({ T($0) })
            .sink { (value) in
            if value != subject.value {
                subject.send(value)
            }
            }.store(in: &subscriptions)
        
    }
}
