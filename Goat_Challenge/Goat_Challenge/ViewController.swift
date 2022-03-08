//
//  ViewController.swift
//  Goat_Challenge
//
//  Created by TZ Wang on 3/8/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var helloTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray
        textView.text = "Hello Goat"
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
        view.addSubview(helloTextView)
        helloTextView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
    }


}

