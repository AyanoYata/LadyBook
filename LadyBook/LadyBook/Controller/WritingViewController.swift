import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
//import FirebaseStorage
//import FirebaseUI

class WritingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    
    var articles: [Article] = []
    let db = Firestore.firestore()
    //let storage = Storage.storage()
    
    @IBOutlet weak var nextButton: UIButton!
    

    @IBOutlet weak var writingImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var articleTextView: UITextView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:))))
        
        self.titleTextField.delegate = self
        self.articleTextView.delegate = self
        
    }
    
    
    //ImageViewをタップしたときのアクション
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        print("imageView をタップした")
        // アクションシートを表示
        let alertSheet = UIAlertController(title: nil, message: "選択してください", preferredStyle: .actionSheet)
        //カメラを選んだとき
        let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { action in
            print("カメラが選択されました")
            self.presentPicker(sourceType: .camera)
        }
        //アルバムを選んだとき
        let albumAction = UIAlertAction(title: "アルバムから選択", style: .default) { action in
            print("アルバムが選択されました")
            self.presentPicker(sourceType: .photoLibrary)
        }
        //キャンセルを選んだとき
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
            print("キャンセルが選択されました")
        }
        //それぞれのアクションをひもづける
        alertSheet.addAction(cameraAction)
        alertSheet.addAction(albumAction)
        alertSheet.addAction(cancelAction)
        present(alertSheet, animated: true)
    }
    
        // カメラとアルバムの画面を生成する
        func presentPicker(sourceType:UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                // UIImagePickerControllerのソースタイプが利用できるとき
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                // デリゲート先はこのclassを指定
                picker.delegate = self
                //画面を表示する
                present(picker, animated: true, completion: nil)
            } else {
                //利用できるソースタイプが無いときはエラー表示
                print("The SourceType is not found")
            }
        }
        
        //撮影 or アルバム を選択したときの処理
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("撮影もしくは画像を選択しました")
            
            if let pickedImage = info[.originalImage] as? UIImage{
                //撮影 or 選択した画像をwritingImageViewの中身に入れる
                writingImageView.image = pickedImage
                writingImageView.contentMode = .scaleAspectFit
            }
            //表示した画面を閉じる
            picker.dismiss(animated: true, completion: nil)
        }
       
    // TitleのKeyboardを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
            return false
        }
    
    
    #warning("TextView入力後、リターンキーでkeyboardを閉じるコード")
    // StoryのKeyboardを閉じる
    func articleTextViewShouldReturn(_ textView: UITextView) -> Bool {
            //textView.resignFirstResponder()
            //articleTextView.text = textView.text
        //titleTextField.text = textField.text
    self.view.endEditing(true)
            return false
        }

    
    
    @IBAction func tapNextButton(_ sender: Any) {
       
    }
    //NextButtonをタップし、次のページに遷移した際 imageView,title,Storyの値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
           let writingAddViewController = navigationController.viewControllers.first as? WritingAddViewController {
            writingAddViewController.titleTextField = titleTextField
            writingAddViewController.articleTextView = articleTextView
            writingAddViewController.writingImageView = writingImageView
        }
    }
    
    
    
    
}
 

