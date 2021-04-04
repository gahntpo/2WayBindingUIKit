//
//  SliderViewController.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

import UIKit
import Combine

class SliderViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet var lable: UILabel!
    
    let numberSubject = CurrentValueSubject<Double, Never>(0)
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.createBinding(with: numberSubject, storeIn: &subscriptions)
        
        numberSubject
            .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: true)
            .map({ value in
                "number: \(value)"
            })
            .assign(to: \.text ,on: lable)
            .store(in: &subscriptions)
        
        zeroButton.tapPublisher().sink { [unowned self] _ in
            self.numberSubject.send(0)
        }.store(in: &subscriptions)
    }


}
