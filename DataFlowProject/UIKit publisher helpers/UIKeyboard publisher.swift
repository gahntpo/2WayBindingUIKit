//
//  UIKeyboard publisher.swift
//  CoordinatorTest
//
//  Created by Karin Prater on 31.03.21.
//

import Foundation
import UIKit
import Combine


struct KeyboardState: Equatable {
    
    var state: Transition = .unset
    
    var isVisible: Bool {
        switch self.state {
        case .didHide, .willHide, .willShow, .unset:
           return false
        case .didShow:
            return true
        }
    }
    
    var frame:CGRect = CGRect.zero
    var animationDuration = 0.0
    
    private let frameEnd = UIResponder.keyboardFrameEndUserInfoKey
    private let animEnd = UIResponder.keyboardAnimationDurationUserInfoKey
    
    init(with notification: Notification? = nil, state: Transition = .unset){
        self.state = state
        if let notification = notification {
            self.frame = notification.userInfo?[frameEnd] as! CGRect
            let duration = notification.userInfo?[animEnd] as! NSNumber
            self.animationDuration = duration.doubleValue
        }
    }
    
    enum Transition{
        case unset, willShow, didShow, willHide, didHide
    }
}


extension UIResponder {
    
    static func keyboardPublisher() -> AnyPublisher<KeyboardState, Never> {
    
    let pub1 = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification, object: nil)
        .compactMap({ notification in
            return KeyboardState(with: notification, state: .willShow)
        })
        .replaceError(with: KeyboardState())
    
    let pub2 =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardDidHideNotification, object: nil)
        .compactMap({ notification in
            return KeyboardState(with: notification, state: .didHide)
        })
        .replaceError(with: KeyboardState())
    
    let pub3 =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardDidShowNotification, object: nil)
        .compactMap({ notification in
            return KeyboardState(with: notification, state: .didShow)
        })
        .replaceError(with: KeyboardState())
    
    let pub4 =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification, object: nil)
        .compactMap({ notification in
            return KeyboardState(with: notification, state: .willHide)
        })
        .replaceError(with: KeyboardState())
    
    return pub1.merge(with: pub2, pub3, pub4)
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
}
