import UIKit

class WikipediaImageDisplayVC: UIViewController {


    @IBOutlet weak var searchField: UITextField!


    //What I love about this method is that it is linked from Storyboard. It handles any changes made within the UITextField, thus within the IBAction I just called the the class function from the WikipediaAPIClient and continously checked for user input changes made in the text field.
    @IBAction func textFieldChanged(_ sender: UITextField) {
        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") { (response) in
            DispatchQueue.main.async {
                print("it worked")
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //the reason why this appears in viewWillAppear is because viewWillAppear gets called every time when you enter in that UIViewController and it is the place load the API when you want to get refreshed data (updated data).
    override func viewWillAppear(_ animated: Bool) {
        textFieldChanged(searchField)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

