import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class ArticleViewController: UIViewController {

    
    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!
    
    
    var articles: [Article] = []
    let db = Firestore.firestore()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}
