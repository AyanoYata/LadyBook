import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI

class ArticleViewController: UIViewController {

    
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    

    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Firestoreから読み込み
    func readTasksFromFirestore(){
        //let articleId = self.getArticleId()
        //作成日時の降順に並べ替えて取得する
        db.collection("Articles").order(by: "createdAt", descending: true).getDocuments { (querySnapShot, err) in
            if let err = err{
                //エラー時
                print("エラー\(err)")
            } else {
                //データ取得に成功
                //取得したDocument群の1つ1つのDocumentについて処理をする
                for document in querySnapShot!.documents{
                    //各DocumentからはDocumentIDとその中身のdataを取得できる
                    print("\(document.documentID) => \(document.data())")
                }
                // for文を全て回し終えたらリロード
               //self.reloadTextField()
            }
        }
    }
    
   
}
/* func reloadTableView() {
 tableView.reloadData()
 }*/
