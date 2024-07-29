import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoogleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                
                print("Sign-in error: \(error.localizedDescription)")
                self.handleSignInError(error)
                return
            }
            
            guard let result = signInResult else { return }
         
            let user = result.user
            let id = user.userID
            let name = user.profile?.name
            let email = user.profile?.email
            
            print(id ?? "No ID")
            print(name ?? "No Name")
            print(email ?? "No Email")
            
          
            self.navigateToGallery()
        }
    }
    
    func handleSignInError(_ error: Error) {
        let nsError = error as NSError
        if nsError.code == GIDSignInError.Code.canceled.rawValue {
          
            print("User canceled the sign-in")
        } else {
            
            print("Sign-in error: \(nsError.localizedDescription)")
        }
    }
    
    func navigateToGallery() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let galleryVC = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController {
            self.navigationController?.pushViewController(galleryVC, animated: true)
        }
    }
}
