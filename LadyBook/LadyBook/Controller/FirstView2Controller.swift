import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift
//import Nuke

class FirstView2Controller: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var first2TableView: UITableView!
    
    //空の配列にデータを追加していく
    var articles: [Article] = []
    //var postDatas: [PostData] = []
    
    
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    
    // 上タブのタイトルボタン　 Indicator・表示版
    var itemInfo: IndicatorInfo = "TestView"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        first2TableView.delegate = self
        first2TableView.dataSource = self
        
        
        first2TableView.rowHeight = UITableView.automaticDimension   // automaticDimension・自動寸法
        first2TableView.estimatedRowHeight = UITableView.automaticDimension // estimatedRowHeight・推定行高
        
        readArticlesFromFirestore()

        configureTableViewCell()
        
    }
    
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TestView")
    }
    
    
    //画面描画の都度、tableViewを更新処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        dump(articles)
        //dump(postDatas)
    }
    
    
    // TableViewCellを読み込む関数
    func configureTableViewCell() {
        // TableViewCellのクラス名を指定してNibを作成
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // Xibに設定したidentifier
        let cellID = "CustomCell"
        // TableViewCellにcellのIdentifierを指定して登録
        first2TableView.register(nib, forCellReuseIdentifier: cellID)
    }

    
    // tableViewのrowの数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return articles.count
    }
 

    // tableViewのCellに表示する内容を返すメソッド(indexPathの個数だけ呼ばれるメソッド)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        // Cellを呼び出すメソッド(ここは覚えてしまおう)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        
       
        if articles.isEmpty == false {
            cell.titleLabel?.text = articles[indexPath.row].title
            cell.articleLabel?.text = articles[indexPath.row].text
        //cell.cellImageView.image = UIImage(named: infoLists[indexPath.row].imageViewName)
        // titleの設定
        //cell.titleLabel.text = infoLists[indexPath.row].title
        //cell.titleLabel.text = "ああああああああああああああああああああああああああああああああああああああああああああああああああ"
        //cell.titleLabel.text = articles[indexPath.row].title
        cell.titleLabel.numberOfLines = 0
        // descriptionの設定
        //cell.articleLabel.text = infoLists[indexPath.row].description
        }
        return cell
    }
    
    // tableViewのCellがタップされた時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        let vc = ArticleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    
    // Firestoreからの読み込み
    func readArticlesFromFirestore(){
        //作成日時の降順に並べ替えて取得する
        db.collection("Articles").order(by: "createdAt", descending: true)/*whereField("category", isEqualTo: "Work")*/.getDocuments { (querySnapShot, err) in
                if let err = err{
                //エラー時
                print("エラー\(err)")
            } else {
                //データ取得に成功
                //取得したDocument群の1つ1つのDocumentについて処理をする
                for document in querySnapShot!.documents{
                    //各DocumentからはDocumentIDとその中身のdataを取得できる
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    
                    if let title = data["title"] as? String,
                       let text = data["text"] as? String,
                       //let imageURL = data["imageURL"] as? String,
                       //let category = data["category"] as? String,
                      // let style = data["style"] as? String,
                       let createdAt = data["createdAt"] as? Timestamp {
                        self.articles.append(Article(articleId: document.documentID, title: title, text: text, createdAt: createdAt))
                        
                       // self.articles.append(Article(articleId: document.documentID, title: title, text: text, createdAt: createdAt, category:category, style: style))
                    }
                    
                    self.first2TableView.reloadData()
                }
            }
        }
    }

}
