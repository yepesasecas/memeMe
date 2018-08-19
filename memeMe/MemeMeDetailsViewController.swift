//
//  MemeMeDetailsViewController.swift
//  memeMe
//
//  Created by Andres Yepes on 8/19/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

class MemeMeDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let meme = self.meme{
            self.imageView.image = meme.memeImage
        }
    }

}
