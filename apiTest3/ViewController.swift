//
//  ViewController.swift
//  apiTest3
//
//  Created by lcx on 2021/10/21.
//

import UIKit
import Amplify

class ViewController: UIViewController {
    
    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var sum: UITextField!
    private let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func num1DidChange(_ sender: Any) {
        updateSum()
    }
    
    @IBAction func num2DidChange(_ sender: Any) {
        updateSum()
    }
    
    private func updateSum() {
        guard let num1Text = num1.text,
              let num2Text = num2.text,
              num1Text != "",
              num2Text != ""
        else {
            return
        }
        
        let queryParameters = [
            "num1": num1Text,
            "num2": num2Text
        ]
        let request = RESTRequest(
            path: "/hello",
            queryParameters: queryParameters
        )
        Amplify.API.get(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try self.decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.sum.text = "\(response.sum)"
                    }
                } catch {
                    print("unable to convert json to struct due to invalid input")
                }
            case .failure(let apiError):
                print("Failed", apiError)
            }
        }
    }
    
    private struct Response: Codable {
        var message: String
        var sum: Int
    }
}

