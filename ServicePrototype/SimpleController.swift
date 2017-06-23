//
//  ViewController.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 10/17/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import UIKit

protocol SimpleViewModelProtocol {
    var key: Dynamic<String> { get }
    var foo: Dynamic<String> { get }
    var number: Dynamic<Int> { get }
    func updateSimple()
}

class SimpleController: UIViewController {
    
    @IBOutlet weak var display1: UILabel!
    @IBOutlet weak var display2: UILabel!
    @IBOutlet weak var display3: UILabel!
    
    @IBAction func button() {
        if let viewModel = simpleViewModel {
            viewModel.updateSimple()
        }
    }
    
    var simpleViewModel: SimpleViewModelProtocol? {
        didSet {
            if let viewModel = simpleViewModel {
                viewModel.foo.bindAndFire { [unowned self] in
                    self.display1.text = $0
                }
                viewModel.key.bindAndFire { [unowned self] in
                    self.display2.text = $0
                }
                viewModel.number.bindAndFire { [unowned self] in
                    self.display3.text = "\($0)"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        self.simpleViewModel = SimpleViewModel()
    }
}


