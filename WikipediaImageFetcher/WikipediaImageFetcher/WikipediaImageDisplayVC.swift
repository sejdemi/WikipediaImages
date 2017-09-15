import UIKit

class WikipediaImageDisplayVC: UIViewController {


    @IBOutlet weak var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        WikipediaAPIClient.generateWikipediaImages(for: "Cat") { (response) in

//            print(response)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

