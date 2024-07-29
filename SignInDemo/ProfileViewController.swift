import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
  
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = GIDSignIn.sharedInstance.currentUser {
            nameLabel.text = user.profile?.name
            emailLabel.text = user.profile?.email
        }
    }
    @IBAction func logout(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   
}
