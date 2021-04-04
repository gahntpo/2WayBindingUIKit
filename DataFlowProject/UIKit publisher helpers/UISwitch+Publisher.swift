//
//  UISwitch+Publisher.swift
//  TodoCoordinatorApp
//
//  Created by Karin Prater on 31.03.21.
//

import Foundation
import Combine
import UIKit

extension UISwitch {

    func valuePublisher() -> AnyPublisher<Bool, Never> {
        self.publisher(for: .valueChanged)
            .compactMap { ($0 as? UISwitch)?.isOn }
            .eraseToAnyPublisher()
    }
    
    func createBinding(with subject: CurrentValueSubject<Bool, Never>,
                       storeIn subscriptions: inout Set<AnyCancellable>) {
        subject.sink { [weak self] (value) in
            if value != self?.isOn {
                self?.isOn = value
            }
        }.store(in: &subscriptions)
        
        self.valuePublisher().sink { (value) in
            if value != subject.value {
                subject.send(value)
            }
        }.store(in: &subscriptions)
    }
    
    
}
