import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseFirestoreSwift


class ForthViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
   

    
    @IBOutlet weak var forthTableView: UITableView!
    
    
    //article情報の一覧。ここに全ての情報を保持
    var articles: [Article] = []
    var postDatas: [PostData] = []
    //FirestoreのDBのインスタンスを作成
    let db = Firestore.firestore()
    
    
    // 上タブのタイトル
    var itemInfo: IndicatorInfo = "Family"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forthTableView.delegate = self
        forthTableView.dataSource = self
        //CustomeCellの登録
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        forthTableView.register(nib, forCellReuseIdentifier: "CustomCell")
        
    }
    
    //XLPagerTabStripに必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Family")
    }
   
    // TableViewCellを読み込む関数
    func configureTableViewCell() {
        // TableViewCellのクラス名を指定してNibを作成
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        // Xibに設定したidentifier
        let cellID = "CustomCell"
        // TableViewCellにcellのIdentifierを指定して登録
        forthTableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    
    //tableViewのrowの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
        //return postDatas.count
    }
    
    //tableViewのCellに表示する内容を返す(indexPathの個数だけ呼ばれる)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        if articles.isEmpty == false {
        cell.titleLabel?.text = articles[indexPath.row].title
        }
    return cell
    }
    
   //tableViewのCellの高さを決める
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
}
