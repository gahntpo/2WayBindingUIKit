# 2-Way-Binding in UIKit

## Demonstrate how to create a 2 way binding in UIKit with Combine framework

In order to generate a publisher for most UIControl events, I wrote a publisher for UIControl views
UIControl has a **publisher(for event: UIControl.Event) -> UIControl.EventPublisher**
This is the base publisher.

The backpressure is handled according to Combine framework standards. 
You can see this the way the demand from the subscriber drives the way values are send to the subscriber.
For more information, check the WWWDC presentation about [Introducing Combine](https://developer.apple.com/videos/play/wwdc2019/722/) around 06:11min.

## 1-way-Binding: 
I added data streams for the following UIKit views. These create data streams from uicontrol views
- UITextField has a **textPublisher()** -> AnyPublisher<String, Never>
- UIButton has a **tapPublisher()** -> AnyPublisher<Void, Never> 
- UISlider has a **valuePublisher()** -> AnyPublisher<Float, Never>
- UISwitch has a **valuePublisher()** -> AnyPublisher<Bool, Never>
- a publisher for keyboard appear/ disappear is added to UIResponder.**keyboardPublisher()** -> AnyPublisher<KeyboardState, Never>  
   which includes the keyboard frame hight 
- UIScrollView has a **contentOffsetPublisher()** -> AnyPublisher<CGPoint, Never> 

## 2-way-Binding
Similar to the way SwiftUI handles data flow with Binding, I wrote 2-way-Binding data streams with Combine. 
These create a data stream from a CurrentValueSubject to the UI control. A second stream is create back from the uicontrol to the CurrentValueSubject.
- UITextField has a **createBinding(with subject: CurrentValueSubject<String, Never>, storeIn subscriptions:)**
- UISlider has a  **createBinding<T: BinaryFloatingPoint>(with subject: CurrentValueSubject<T, Never>, storeIn subscriptions:)**
- UISwitch has a **createBinding(with subject: CurrentValueSubject<Bool, Never>, storeIn subscriptions:)**


## As an example you can look in the TextViewController:
    @IBOutlet var textField: UITextField!
    textSubject = CurrentValueSubject<String, Never>("Hello")
    var subscriptions = Set<AnyCancellable>()
       
    override func viewDidLoad() {
        super.viewDidLoad() 
        
       //  creates 2 data streams
        textField.textPublisher().sink { [unowned self] (value) in
            self.textSubject.send(value)
        }.store(in: &subscriptions)

        textSubject.assign(to: \.text, on: textField)
         .store(in: &subscriptions)
         
        //creates 2 data streams in one step
       textField.createBinding(with: textSubject, storeIn: &subscriptions)
   }
   
   
**This is how SwiftUI does it:**
   ![](images/Screenshot%20SwiftUI.png)
   
**This is how you can do it now in UIKit:**
   ![](images/Screenshot%20UIkit.png)


