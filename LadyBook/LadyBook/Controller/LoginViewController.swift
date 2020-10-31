import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func tappedSignUpButton(_ sender: Any) {
        // emailはnilの可能性があるためアンラップしておく
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        self.emailSignUp(email: email, password: password)
    }

    
    
    func emailSignUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error as NSError? {
                // エラー時の処理
                } else {
                //成功時の処理
                    //self.present
                    let nextvc = self.storyboard?.instantiateViewController(identifier: "WritingView") as! WritingViewController
                    self.navigationController?.pushViewController(nextvc, animated: true)
                    
            }
        }
    }
   
    
    
    

}
