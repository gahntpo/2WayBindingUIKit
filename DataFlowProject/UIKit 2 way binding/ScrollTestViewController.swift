//
//  ScrollTestViewController.swift
//  DataFlowProject
//
//  Created by Karin Prater on 04.04.21.
//

import UIKit
import Combine

class ScrollTestViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var scrollViewBottomContraint: NSLayoutConstraint!
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        self.view.backgroundColor = .blue
//
//        scrollView.contentOffsetPublisher().sink { (offset) in
//            print(offset)
//        }.store(in: &subscriptions)
        

        
        UIResponder.keyboardPublisher().sink { [unowned self] (state) in

            if state.state == .willShow,
               let view = [self.textField, self.secondTextField].first(where: { $0.isFirstResponder }) {
                let refRect = view.frame
           
                print(" \(state.frame.minY) - \(scrollView.frame.height) - first responder \(refRect.maxY) \n")
                if refRect.maxY > state.frame.minY {
               
                   // let offset = CGPoint(x: 0, y: self.view.frame.height - state.frame.height)
                    let offset = CGPoint(x: 0, y: refRect.maxY - state.frame.height + inset * 2)
                    self.scrollView.setContentOffset(offset , animated: true)
              }
            }
            // if state.state == .didShow {
            let offset = (state.isVisible) ? state.frame.height : 0
            self.scrollViewBottomContraint.constant = -offset
            
            
        }.store(in: &subscriptions)
    }

    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width:2000, height: 5678)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollViewBottomContraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.scrollViewBottomContraint.isActive = true
        self.scrollViewBottomContraint.constant = 0
       // scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.backgroundColor = .white
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    let inset: CGFloat = 20
    
    func setupViews(){
     
        let stack = UIStackView(arrangedSubviews: [titleLabel, textField,  subtitleLabel, secondTextField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        stack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
 
        
    }
    
    lazy var textField: UITextField = {
        let text = UITextField()
        text.text = "enter text"
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var secondTextField: UITextField = {
        let text = UITextField()
        text.borderStyle = .roundedRect
        text.text = "enter text"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
           label.numberOfLines = 0
           label.sizeToFit()
//           label.textColor = UIColor.white
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       lazy var subtitleLabel: UILabel = {
           let label = UILabel()
           label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? ostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
           label.numberOfLines = 0
           label.sizeToFit()
           
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
}
