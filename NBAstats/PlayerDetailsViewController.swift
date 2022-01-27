//
//  PlayerDetailsViewController.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/21/22.
//

import UIKit
import AlamofireImage

class PlayerDetailsViewController: UIViewController {

    var players = [Teams]()
    var team:Teams?
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var playerNumLabel: UILabel!
    @IBOutlet weak var birthCityLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.firstNameLabel.text = self.team?.FirstName
            self.lastNameLabel.text = self.team?.LastName
            self.birthCityLabel.text = self.team?.BirthCity
            self.teamNameLabel.text = self.team?.Team
            //self.positionLabel.text = self.team?.Position
            
            if self.team?.Position == "SF"{
                self.positionLabel.text = "Small Forward (SF)"
            }
            else if self.team?.Position == "C"{
                self.positionLabel.text = "Center (C)"
            }
            else if self.team?.Position == "PG"{
                self.positionLabel.text = "Point Guard (PG)"
            }
            else if self.team?.Position == "PF"{
                self.positionLabel.text = "Power Forward (PF)"
            }
            else if self.team?.Position == "SG"{
                self.positionLabel.text = "Shooting Guard (SG)"
            }
            else{
                self.positionLabel.text = self.team?.Position
            }
            
            var jersey = "\(String(describing: self.team?.Jersey!))"
            jersey = jersey.replacingOccurrences(of: "Optional", with: "", options: NSString.CompareOptions.literal, range: nil)
            self.playerNumLabel.text = jersey
            
            let feet = ((self.team?.Height!)!) / 12
            let inches = ((self.team?.Height!)!) - (feet * 12)
            
            
            let height = "\(String(feet))\' \(String(inches))\""
            self.heightLabel.text = height
            
            var weight = "\(String(describing: self.team?.Weight!)) lbs"
            weight = weight.replacingOccurrences(of: "Optional(", with: "", options: NSString.CompareOptions.literal, range: nil)
            weight = weight.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
            self.weightLabel.text = weight
            
            let posterPath = self.team?.PhotoUrl
            let posterUrl = URL(string: posterPath!)!
            self.playerImage.af.setImage(withURL: posterUrl)
            
        }
    
        // Do any additional setup after loading the view.
    }
    
    
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Players?key=3c946f20e66f4d8bab445c653a51395b")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.players = try JSONDecoder().decode([Teams].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
            else{
                print("ERRORRRR")
            }
            
        }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
