//
//  MemeMeTableViewController.swift
//  memeMe
//
//  Created by Andres Yepes on 8/16/18.
//  Copyright © 2018 Andres Yepes. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UITableViewController {
    
    var memes: [Meme]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memes = self.memes{
            return memes.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memeCell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeMeTableViewCell
        if let memes = self.memes{
            let meme = memes[indexPath.row]
            memeCell.descriptionLabel.text = "\(meme.topText) - \(meme.bottomText)"
            memeCell.memeView.image = meme.memeImage
        }
        return memeCell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! MemeMeDetailsViewController
        if let memes = self.memes{
            detailsVC.meme = memes[indexPath.row]
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
