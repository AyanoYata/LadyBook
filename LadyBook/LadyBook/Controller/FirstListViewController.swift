import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirstListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var firstTableView: UITableView!
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        //CustomeCellの登録
        let nib = UINib(nibName: "CustomeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomeCell")
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        self.articles.removeAll()
        self.readArticlesFromFirestore()
        dump(articles)
        }
    

    
    
   //Firestoreからの読み込み
    func readArticlesFromFirestore(){
        //作成日時の降順に並べ替え、情報を取得
        db.collection("Articles").order(by: "createdAt", descending: true).getDocuments { (querySnapShot, err) in
            if let err = err{
                print("エラー\(err)")
            } else {
                for document in querySnapShot!.documents{
                    print("\(document.documentID) => \(document.data())")
                    do {
                        let decodedArticle = try Firestore.Decoder().decode(Article.self, from: document.data())
                        self.articles.append(decodedArticle)
                    } catch let error as NSError{
                        print("エラー\(error)")
                      }
                    }
                self.reloadTableView()
                }
            }
        }
    //tableViewのrowの数を返すDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Customecell", for: indexPath) as! CustomeCell
        if articles.isEmpty == false {
        cell.titleLabel.text = articles[indexPath.row].title
        }
    return cell
    }
func reloadTableview(){
    tableView.reloadData()
  }

}



