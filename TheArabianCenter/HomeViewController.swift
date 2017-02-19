//
//  HomeViewController.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/18/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import FacebookCore
import FacebookShare
import TwitterKit

protocol HomeViewControllerInput
{
    func displaySomething(viewModel: Home.Something.ViewModel)
}

protocol HomeViewControllerOutput
{
    func doSomething(request: Home.Something.Request)
}

class HomeViewController: UIViewController, HomeViewControllerInput
{
    var output: HomeViewControllerOutput!
    var router: HomeRouter!
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        HomeConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomethingOnLoad()
        
    }
    
    // MARK: - Event handling
    
    @IBAction func facebookShare(){
        
        let shareContent = LinkShareContent(url: URL(string: "https://fb.me/596147463923380?couponcode=1234")!, title: "PromoCode", description: "Show me", quote: nil, imageURL: nil)
        
        let shareDialog:ShareDialog = ShareDialog(content: shareContent)
        shareDialog.mode = .automatic
        
        shareDialog.completion = { result in
            switch result {
            case let .success(contentResult):
                break
            case .cancelled:
                break
            case let .failed(error):
                break
            }
        }
        do{
            try shareDialog.show()
        }catch{
            print(error)
        }
    }
    
    @IBAction func twitterShare(){
        
        let composer = TWTRComposer()
        composer.setURL(URL(string:"https://firebasestorage.googleapis.com/v0/b/ios-test-b99cb.appspot.com/o/index.html?alt=media&token=8c73fe54-1e3e-40eb-8e99-8567e65f4f3b&couponcode=1234"))
        composer.show(from: self) { (result) in
            switch result{
            case .done:
                print("done")
            case .cancelled:
                print("canceled")
            }
        }
    }
    
    func doSomethingOnLoad()
    {
        // NOTE: Ask the Interactor to do some work
        
        let request = Home.Something.Request()
        output.doSomething(request: request)
    }
    
    // MARK: - Display logic
    
    func displaySomething(viewModel: Home.Something.ViewModel)
    {
        // NOTE: Display the result from the Presenter
        
        // nameTextField.text = viewModel.name
    }
}