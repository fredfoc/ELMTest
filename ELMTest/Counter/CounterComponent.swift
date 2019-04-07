//
//  CounterComponent.swift
//  ELMTest
//
//  Created by admin on 05/04/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CounterComponentView: class {
    var counterLabel: UILabel! {get}
    var incrementButton: UIButton! {get}
    var decrementButton: UIButton! {get}
}

class CounterComponent {
    
    let view: CounterComponentView
    let disposeBag = DisposeBag()
    var context = Context()
    
    init(view: CounterComponentView) {
        self.view = view
        self.context = Context()
        context.publish
            .subscribe({[weak self] event in
                guard let model = event.element else {
                    return
                }
              self?.render(model)
                })
            .disposed(by: disposeBag)
    }
    
    func bindView() {
        view.incrementButton.rx
            .tap
            .bind {[weak self] in
                self?.context.dispatch(.increment)
            }
            .disposed(by: disposeBag)
        view.decrementButton.rx
            .tap
            .bind {[weak self] in
                self?.context.dispatch(.decrement)
            }
            .disposed(by: disposeBag)
    }
    
    private func render(_ model: Model) {
        view.counterLabel.text = String(model.counter)
    }
    
    enum Message {
        case increment
        case decrement
    }
    
    struct Model {
        var counter: Int
    }
    
    struct Context {
        var publish = PublishSubject<Model>()
        var model = Model(counter: 0)
        
        mutating func dispatch(_ message: Message) {
            model = update(message)(model)
            publish.onNext(model)
        }
        
        func update(_ message: CounterComponent.Message) -> ((CounterComponent.Model) -> CounterComponent.Model) {
            switch message {
            case .increment:
                return { model in
                    return Model(counter: model.counter + 1)}
            case .decrement:
                return { model in
                    return Model(counter: model.counter - 1)}
            }
        }
        
    }
}
