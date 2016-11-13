//
//  ViewController.swift
//  ReduxsterExample
//
//  Created by Rogerio de Paula Assis on 13/11/16.
//  Copyright © 2016 Freshmob Pty Ltd. All rights reserved.
//

import UIKit
import Reduxster

let reducer = AppReducer()
var store = Store(reducer: reducer)

class ViewController: UIViewController, Subscriber {
    
    var state: State?
    var identifier: String = NSUUID().uuidString
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateSomething() {
        let action = AppAction.testAction(self.textField.text ?? "")
        store.dispatchAction(action: action)
    }
    
    func setState(state: State) {
        if let state = state as? AppState {
            self.label.text = state.textValue
        }
    }


}

