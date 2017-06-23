//
//  SimpleViewModel.swift
//  ServicePrototype
//
//  Created by Isaac Perry on 10/18/16.
//  Copyright © 2016 Isaac Perry. All rights reserved.
//

import Foundation
class SimpleViewModel: SimpleViewModelProtocol {
    var simpleModel: SimpleStruct
    
    var key: Dynamic<String>
    var foo: Dynamic<String>
    var number: Dynamic<Int>
    
    init() {
        if let savedSimpleModel = StoredData.simple {
            self.simpleModel = savedSimpleModel
        } else {
            self.simpleModel = SimpleStruct.getMockSimpleStruct()
        }
        self.key = Dynamic(self.simpleModel.key)
        self.foo = Dynamic(self.simpleModel.sub!.foo)
        self.number = Dynamic(self.simpleModel.sub!.number)
    }
    
    func updateSimple() {
        Service.getSimple { [unowned self] in
            self.simpleModel = $0
            self.key.value = $0.key
            self.foo.value = $0.sub!.foo
            self.number.value = $0.sub!.number
            StoredData.simple = $0
        }
    }
}
