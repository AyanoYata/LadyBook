import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift
import Nuke


class FirstViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var writingButton: UIButton!
    
    //空の配列にデータを追加していく
    var articles: [Article] = []
    var postDatas: [PostData] = []
    
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    // 上タブのタイトルボタン　 Indicator・表示版
    var itemInfo: IndicatorInfo = "Top"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        firstTableView.rowHeight = UITableView.automaticDimension   // automaticDimension・自動寸法
        firstTableView.estimatedRowHeight = UITableView.automaticDimension // estimatedRowHeight・推定行高
        
    
        readArticlesFromFirestore()
        
        configureTableViewCell()
    }

        
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Top")
    }
    
    
    //画面描画の都度、tableViewを更新処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppearが呼ばれた")
        
        dump(articles)
        dump(postDatas)
    }
    
    
    @IBAction func tapWritingButton(_ sender: Any) {
        let nextvc = storyboard?.instantiateViewController(identifier: "LoginView") as! LoginViewController
        navigationController?.pushViewController(nextvc, animated: true)
        
        print("------ self.navigationController ------")
        print(self.navigationController)// navigetionControllerの中の初期値
        print("------ self.navigationController ------")
    }

    
    // TableViewCellを読み込む関数
    func configureTableViewCell() {
        // TableViewCellのクラス名を指定してNibを作成
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // Xibに設定したidentifier
        let cellID = "CustomCell"
        // TableViewCellにcellのIdentifierを指定して登録
        firstTableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        
        if articles.isEmpty == false {
            cell.titleLabel?.text = articles[indexPath.row].title
            //cell.articleLabel?.text = articles[indexPath.row].text
            // Nukeで画像を表示させる
            //print(articles[indexPath.row].imageURL)
            //_ = Nuke.loadImage(with: getDownloadUrlStr, into: self.writingImageView)
          

        }
        return cell
    }
    
    // tableViewのCellがタップされた時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt:", indexPath)
        let vc = ArticleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // tableViewのCellの高さ
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }*/
    
    
    // Firestoreからの読み込み
    func readArticlesFromFirestore(){
        //作成日時の降順に並べ替えて取得する
        db.collection("Articles").order(by: "createdAt", descending: true)/*.whereField("category", isEqualTo: "Work")*/.getDocuments { (querySnapShot, err) in
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
                       //let text = data["text"] as? String,
                       //let imageURL = data["imageURL"] as? String,
                       //let category = data["category"] as? String,
                      // let style = data["style"] as? String,
                       let createdAt = data["createdAt"] as? Timestamp {
                        self.articles.append(Article(articleId: document.documentID, title: title, createdAt: createdAt))
                        
                       // self.articles.append(Article(articleId: document.documentID, title: title, text: text, createdAt: createdAt, category:category, style: style))
                    }
                    
                    self.firstTableView.reloadData()
                }
            }
        }
    }
    
}

