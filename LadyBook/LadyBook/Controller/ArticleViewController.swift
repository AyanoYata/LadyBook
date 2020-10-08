import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI
import Nuke


class ArticleViewController: UIViewController, UITabBarDelegate {
    
    
    var articleId: String?
    
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    private var myTabBar:MyTabBar!
    
    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var imageRateLayoutConstraint: NSLayoutConstraint!
    
    
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
        
        // TabBar設置
        let width = self.view.frame.width
        let height = self.view.frame.height
        let tabBarHeight:CGFloat = 58
        
        
        myTabBar = MyTabBar()
        myTabBar.frame = CGRect(x:0,y:height - tabBarHeight,width:width,height:tabBarHeight)
        //バーの色
        myTabBar.barTintColor = UIColor.systemGray4
        //選択されていないボタンの色
        myTabBar.unselectedItemTintColor = UIColor.white
        //ボタンを押した時の色
        myTabBar.tintColor = UIColor.systemPink
        
        //ボタンを生成(文字と画像)
        let config1:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"home.png"), tag: 1)
        let config2:UITabBarItem = UITabBarItem(title: "Search", image: UIImage(named:"search.png"), tag: 2)
        let config3:UITabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named:"heart.png"), tag: 3)
        let config4:UITabBarItem = UITabBarItem(title: "Mypage", image:
                                                    UIImage(named:"person.png"), tag: 4)
        //ボタンをタブバーに配置する
        myTabBar.items = [config1,config2,config3,config4]
        //デリゲートを設定する
        myTabBar.delegate = self
        
        self.view.addSubview(myTabBar)
        //バーの色①
        myTabBar.barTintColor = UIColor.lightGray
        //選択されていないボタンの色②
        myTabBar.unselectedItemTintColor = UIColor.white
        
        myTabBar.items = [config1,config2,config3,config4]
    }
    
    // 各Tabの動き
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag{
        case 1:
            let nextVC = self.storyboard?.instantiateViewController(identifier: "First") as! FirstViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        //case 2:
        //case 3:
        //case 4:
        
        default : return
            
        }
    }
}

