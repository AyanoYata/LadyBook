import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI
import Nuke

class ArticleViewController: UIViewController {
    
    
    var articleId: String?
    
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    
    #warning("<#T##message###>")
    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!
    
    #warning("UIPickerで選択した Category,Style")
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  db.collection("Articles").document(articleId!).getDocumentで、articleIdのデータを取り出し表示する
        db.collection("Articles").document(articleId!).getDocument { (documentSnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let documentSnapshot = documentSnapshot {
                let data = documentSnapshot.data()
                
                self.titleTextField.text = data?["title"] as? String
                self.articleTextView.text = data?["text"] as? String
                //imageURLをwritingImageViewに反映させる
                if let imageURL = data?["imageURL"] as? String {
                    Nuke.loadImage(with: URL(string: imageURL)!, into: self.writingImageView)
                    
                    Nuke.loadImage(with: URL(string: imageURL)!, options: ImageLoadingOptions(), into: self.writingImageView, progress: nil) { (result: Result<ImageResponse, ImagePipeline.Error>) in
                        
                        switch result {
                        case .success(let imageResponse):
                            self.imageRateLayoutConstraint.constant = imageResponse.image.size.width / imageResponse.image.size.height
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
}
