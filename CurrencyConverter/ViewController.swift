

import UIKit

class ViewController: UIViewController {

    var tryLabel =  UILabel()
    var cucLabel = UILabel()
    var usdLabel = UILabel()
    var getRatesButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        view.backgroundColor = .white
    }
    
    
    
    func createUI() {
        setDefaultSize(view: view)
        tryLabel.frame = CGRect(x: 0.2 * screenWidth, y: 0.2 * screenHeight, width: 0.6 * screenWidth, height: 50)
        cucLabel.frame = CGRect(x: 0.2 * screenWidth, y: 0.3 * screenHeight, width: 0.6 * screenWidth, height: 50)
        usdLabel.frame = CGRect(x: 0.2 * screenWidth, y: 0.4 * screenHeight, width: 0.6 * screenWidth, height: 50)
        getRatesButton.frame = CGRect(x: 0.3 * screenWidth, y: 0.5 * screenHeight, width: 0.4 * screenWidth, height: 50)
        getRatesButton.setTitle("Get Rates", for: .normal)
        getRatesButton.addTarget(self, action: #selector(getRatesButtonClicked), for: .touchUpInside)
        getRatesButton.backgroundColor = .systemPink
        view.addSubview(tryLabel)
        view.addSubview(cucLabel)
        view.addSubview(usdLabel)
        view.addSubview(getRatesButton)

    }
    
    
    
    

    @objc func getRatesButtonClicked() {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        
      
        let session = URLSession.shared

        
        //        Closure
        let task = session.dataTask(with: url!) { data, _, error in
            

            if error != nil {
                let alert = UIAlertController(title: "Error", message:error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                //
                if data != nil {
                    
                    do {
                        
                        let response = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary <String,Any>
                        //cast onemli String -->Any
                        
                        //mutable container icinde degistirilebilir json formati olusturuldu
                        
                        //asagidaki satir ASYNC calisir
                        
                        DispatchQueue.main.async {
                            
                            if let rates = response! ["rates"] as? [String : Any] {
                                
                                
                                if let twd = rates["TWD"] as? Double {
                                    self.tryLabel.text = "TWD : \(twd)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let cuc = rates["UYU"] as? Double {
                                    self.cucLabel.text = "UYU : \(cuc)"
                                
                                }
                                
                               
                            }
                            
                    
                        }
                        
                    }catch {
                        
                    }
                    
                    
                }
            }
        }
            
        task.resume()
    }
    
}

