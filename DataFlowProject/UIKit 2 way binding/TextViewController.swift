//
//  TextViewController.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

//MARK: - data streams between Combine publisher and UITextField

import UIKit
import Combine

class TextViewController: UIViewController {

    let textSubject = CurrentValueSubject<String, Never>("Hello")
    var subscriptions = Set<AnyCancellable>()

    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        textField.textPublisher().sink { [unowned self] (value) in
//            self.textSubject.send(value)
//        }.store(in: &subscriptions)
//
//        textSubject.sink { [unowned self]  (value) in
//            textField.text = value
//        }.store(in: &subscriptions)
        
       
        textField.createBinding(with: textSubject, storeIn: &subscriptions)
        
        textSubject.sink { [unowned self] (value) in
            self.lable.text = value
        }.store(in: &subscriptions)
        
        clearPressed.tapPublisher().sink { [unowned self] _ in
            self.textSubject.send("")
        }.store(in: &subscriptions)
        
     
    }
    
    
}
