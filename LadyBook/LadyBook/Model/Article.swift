import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseUI

//記事に持たせる機能class
class Article: NSObject {
    
    //Top画面に表示される記事
    //article単位で1つのDocumentになる。
    var articleId: String
    var title: String?
    var imageURL: String?
    var text: String?
    var date: Date?
    //var category: String
    //var style: String
    
    
    
    init(document: QueryDocumentSnapshot) {
        self.articleId = document.documentID
        
        let postDic = document.data()

        self.title = postDic["title"] as? String

        self.imageURL = postDic["imageURL"] as? String
        
        self.text = postDic["text"] as? String
        // 作成日
        let timestamp = postDic["createdAt"] as? Timestamp
        self.date = timestamp?.dateValue()
        
    }
}

/*init(articleId: String, title: String, text: String = "", createdAt:Timestamp, updatedAt:Timestamp) {
    self.articleId = articleId
    self.title = title
    //self.titleImage = titleImage
    self.text = text
    //self.category = category
   // self.style = style
    self.createdAt = createdAt
    self.updatedAt = updatedAt
}*/
