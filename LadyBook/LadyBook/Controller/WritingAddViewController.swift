import UIKit
import PKHUD
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI

class WritingAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var articles: [Article] = []
    var postDatas: [PostData] = []
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    //UIPickerView
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var stylePicker: UIPickerView!
    
    //Label
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    //Button
    @IBOutlet weak var releaseButton: UIButton!
    @IBOutlet weak var draftButton: UIButton!
    
    
    var titleTextField =  UITextField()
    var articleTextView = UITextView()
    var writingImageView = UIImageView()
    
    
    let categoryList = ["Work","Love","Family","Life"]
    var categoryPickerView = UIPickerView()
    
    
    let styleList = ["episode","essay","my history"]
    var stylePickerView =  UIPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        stylePickerView.delegate = self
        stylePickerView.dataSource = self
        //categoryLabel.inputView = pickerView
    }
    
    //Firestoreへの書き込み(title,text)
    func createToFirestore(_ title:String){
        //let articleId = self.getArticleId()
        // articleIDに割り振るランダムな文字列を生成
        let articleId = db.collection("Articles").document().documentID
        //  articleIdを使ってArticleのインスタンスを作成
        let article = Article(articleId: articleId, title: title, text: articleTextView.text, createdAt: Timestamp())
        //  Firestoreには、[String:Any]型で記録するため、Task型を変換する ※Encoder()にしないとエラーになるので注意
        do{
            //エラー処理を強制されている関数は、tryをつけて処理する。tryをつけた箇所をdo{}で囲み、do~catch文を使って処理する。
            let encodedArticle:[String:Any] = try Firestore.Encoder().encode(article)
            //変換に成功したとき
            db.collection("Articles").document(articleId).setData(encodedArticle)
            articles.append(article)
        } catch let error as NSError {
            //変換に失敗したとき
            print("エラー\(error)")
        }
    }
    
    //FireStoreへ書き込みす(image→ StorageにてURLを取得し保存)
    func saveToFirestore() {
            if let selectImage = writingImageView.image {
            // 今日日付をintに変換して被らない名前にする
            let imageName = "\(Date().timeIntervalSince1970).jpg"
            // 今回はpostsというフォルダーの中に画像を保存する
            let reference = Storage.storage().reference().child("posts/\(imageName)")
            // 画像データがそのままだとサイズが大きかったりするので、サイズを調整
            if let imageData = selectImage.jpegData(compressionQuality: 0.8) {
                // メタデータを設定
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                // ①ここでstorageへの保存を行う
                reference.putData(imageData, metadata: metadata, completion:{(metadata, error) in
                    if let _ = metadata {
                        // ②storageへの保存が成功した場合はdownloadURLの取得を行う
                        reference.downloadURL{(url,error) in
                            if let downloadUrl = url {
                                // downloadURLの取得が成功した場合
                                // String型へ変換を行う
                                let downloadUrlStr = downloadUrl.absoluteString
                                // ③firestoreへ保存を行う
                                Firestore.firestore().collection("posts").document().setData([
                                    //"title": title,
                                    //"text": text,
                                    "imageURL": downloadUrlStr,
                                    "createdAt": FieldValue.serverTimestamp()
                                ]){ error in
                                    if error != nil {
                                        // firestoreへ保存が失敗した場合
                                        
                                    } else {
                                        // firestoreへ保存が成功した場合
                                    }
                                }
                            } else {
                                // downloadURLの取得が失敗した場合の処理
                            }
                        }
                    } else {
                        // storageの保存が失敗した場合の処理
                    }
                })
            }
        }
    }
    //公開ボタンを押したときの処理
    @IBAction func tapReleaseButton(_ sender: Any) {
        print("⭐️公開ボタンを押しました")
        guard let title = titleTextField.text else {
            return
        }
        //タイトルが空白の時のエラー処理
        if title.isEmpty {
            print(title, "titleが空です！")
            HUD.flash(.labeledError(title: nil, subtitle: "タイトルが入力されていません！"), delay: 1)
            return
        }
        //Firestoreに保存する処理の完成
        self.saveToFirestore()
        self.createToFirestore(title)
    
        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        //navigationController?.popViewController(animated: true)
    }
    
    //Pickerの列の数（縦）
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Pickerの横の数（行）
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int) -> String? {
        return categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryLabel.text = categoryList[row]
    }
    
    #warning("AritocleViewControllerへの遷移")
    
}
/* //公開ボタンを押したときの処理
 @IBAction func tapReleaseButton(_ sender: Any) {
     guard let title = titleTextField.text else {
         print("公開ボタンを押しました")
         return
     }
     //タイトルが空白の時のエラー処理
     if title.isEmpty {
         print(title, "titleが空です！")
         HUD.flash(.labeledError(title: nil, subtitle: "タイトルが入力されていません！"), delay: 1)
         return
     }
     //Firestoreに保存する処理の完成
     self.saveToFirestore()
     self.createToFirestore(title)
 
     HUD.flash(.success, delay: 0.3)
     // 前の画面に戻る
     //navigationController?.popViewController(animated: true)
 }
 */
