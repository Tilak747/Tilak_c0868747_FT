//
//  ProgressViewController.swift
//  Tilak_c0868747_FT
//
//  Created by Tilak Acharya on 2022-11-07.
//

import Foundation
import UIKit


class ProgressViewController: UIViewController {
    
    var myProgress : Array<GameModel> = []
    weak var delegate : ViewController?
    
    
    @IBOutlet weak var progressTableView: UITableView!
    
    override func viewDidLoad() {
        progressTableView.delegate = self
        progressTableView.dataSource = self
        
        progressTableView.reloadData()
    }
    
}

class ProgressViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ivOutput: UIImageView!
    @IBOutlet weak var labelInput: UILabel!
    
}


extension ProgressViewController:UITableViewDelegate,
                                 UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myProgress.count
    }
    


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = progressTableView.dequeueReusableCell(withIdentifier: "ProgressCell") as? ProgressViewCell{
            let model = self.myProgress[indexPath.row]
            
            var myInput = ""
            if model.myChoice {
                myInput = "Even"
            }
            else {
                myInput = "Odd"
            }
            
            cell.labelInput.text = "\(model.number) is \(myInput)"
            
            if model.result {
                cell.ivOutput.image = UIImage(named: "correct")
            }
            else{
                cell.ivOutput.image = UIImage(named: "incorrect")
            }
            
            return cell
        }
        else {
            return UITableViewCell()
        }
        
    }



}
