//
//  GettingStartedSearchViewController.swift
//  DemoDirectory
//
//  Created by Vladislav Fitc on 29/07/2020.
//  Copyright © 2020 Algolia. All rights reserved.
//

import Foundation
import UIKit
import InstantSearch

enum GettingStartedGuide {
  enum StepOne {}
  enum StepTwo {}
  enum StepThree {}
  enum StepFour {}
  enum StepFive {}
  enum StepSix {}
  enum StepSeven {}
}

/**
 # Getting Started
 
 ## Welcome to InstantSearch iOS
 
 In this guide, we will walk through the few steps needed to start a project with InstantSearch iOS. We will start from an empty iOS project, and create a full search experience from scratch!
 
 ## Before we start
 
 To use InstantSearch iOS, you need an Algolia account. You can create a new account, or use the following credentials:
 - APP ID: latency
 - Search API Key: 1f6fd3a6fb973cb08419fe7d288fa4db
 - Index name: bestbuy
 These credentials give access to a preloaded dataset of products appropriate for this guide.
 
 ## Create a new project
 
 Let’s get started! In Xcode, create a new Project:
 On the Template screen, select Single View Application and click next
 Specify your Product name, select Swift as the language and iPhone as the Device, and then create.
 
 ## Add InstantSearch to the project
 
 To add InstantSearch package dependency to your Xcode project, you need a dependency manager.
 
 ### Swift Package Manager
 
 - Select File > Swift Packages > Add Package Dependency and enter repository URL: https://github.com/algolia/instantsearch-ios
 - You can also navigate to your target’s General pane, and in the “Frameworks, Libraries, and Embedded Content” section, click the + button, select Add Other, and choose Add Package Dependency.
 - In the package products selection dialog, checkmark both `InstantSearch` and `InstantSearchCore` products
 
 ### Cocoapods
 
 - If you don’t have CocoaPods installed on your machine, open your terminal and run sudo gem install cocoapods.
 - Go to the root of your project then type pod init. A Podfile will be created for you.
 - Open your Podfile and add pod 'InstantSearch', '~> 7' below your target.
 - On your terminal, run pod update.
 - Close your Xcode project, and then, at the root of your project, type open projectName.xcworkspace (replacing projectName with the actual name of your project).
 
 ## Let's start!
 
 Open ViewController.swift which automatically generated by Xcode when you create a Single View Application.
 Add `import InstantSearch` at the top.
 
 ## Define your record structure
 
 First of all let's define a structure representing a record in your index. For the sake of simplicity, our structure will only provide the name of the product.
 Structure must conform to `Codable` protocol to work properly with `InstantSearch`. Add the following declaration to ViewController.swift file.
 */

struct BestBuyItem: Codable {
  let name: String
}

/**
 ## Hits view controller
 
 In this example we use `HitsTableViewController` which is the basic implementation of `HitsController` protocol.
 It is a generic view controller parametrized with implementation of `TableViewCellConfigurable` protocol.
 This implementation defines how to bind the record's data to the `UITableViewCell` instance.
 The following implementation binds the name of the fetched item to textLabel's text property of the cell.
 */

struct BestBuyTableViewCellConfigurator: TableViewCellConfigurable {
   
  let model: BestBuyItem
  
  init(model: BestBuyItem, indexPath: IndexPath) {
    self.model = model
  }
  
  func configure(_ cell: UITableViewCell) {
    cell.textLabel?.text = model.name
  }

}

/**
 Finally, let's define a convenient typealias for `HitsTableViewController` parametrized with `CellConfigurator` defined above.
*/

typealias BestBuyHitsViewController = HitsTableViewController<BestBuyTableViewCellConfigurator>

/**
 ## Fill the ViewController
 
  Let's complete the main view controller of our application.  Declare a search controller which is a UIKit component managing the display of search results based on interactions with a search bar. It already contains a search bar inside and just requires a search results controller as a parameter. Let's add `hitsViewController` field to our view controller of type declared in the previous step. Set it as a initializer parameter of the search controller.
 */

extension GettingStartedGuide.StepOne {
  
  class ViewController: UIViewController {
    
    let searchController: UISearchController
    let hitsViewController: BestBuyHitsViewController

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      hitsViewController = .init()
      searchController = .init(searchResultsController: hitsViewController)
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  }

}

/**
 
 ## Initialize your searcher
 
 We have the necessary view controllers, now it's time to add some search logic.
 The central part of our search experience is the Searcher. The Searcher performs search requests and obtains search results. Almost all InstantSearch components are connected with the Searcher. In this tutorial we only target one index, so we will instantiate a SingleIndexSearcher with the proper credentials.
 Then add `searchConnector` property to view controller. Initialize it passing searcher, search controller and hits view controller. In the end, add activate the search connector by calling its `connect()` and then `searcher.search()` to launch the first empty search request immediately.
 */

extension GettingStartedGuide.StepTwo {

  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsViewController)
    let hitsViewController: BestBuyHitsViewController = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      searcher.search()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
            
  }
  
}

/**
 The search logic is fully functional now, but it's not ready to use yet. We need a few more lines of code to setup the UI appearance. Add `setupUI` function to the view controller and call it from the `viewDidLoad` method. Finally, let's override `viewDidAppear` function and add set search bar the first responder so that the search controller present results immediately after the view controller appearance. We are all set now. Build and run your project and you will see the basic search experience with instant results!
 */

extension GettingStartedGuide.StepThree {
  
  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsViewController)
    let hitsViewController: BestBuyHitsViewController = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      searcher.search()
      setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
    
    func setupUI() {
      view.backgroundColor = .white
      navigationItem.searchController = searchController
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.showsSearchResultsController = true
      searchController.automaticallyShowsCancelButton = false
    }
        
  }
  
}

/**
 
 ## Add Stats
 Now let's make our search experience more user-friendly by providing an additional feedback about search results. Along the way, you will discover how extend your search experience with different InstantSearch modules. Showing the hits count gives the user a complete undestanding about search results immediately without need of additional interaction. Let's add a `Stats` components. Stats interactor extracts search meta-data from the response and provides an interface to present it to the user.
 - Add stats interactor to view controller
 - Initialize it in the init method of view controller
 - Connect stats interactor to searcher using `connectSearcher` method
 */

extension GettingStartedGuide.StepFour {
  
  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsViewController)
    let hitsViewController: BestBuyHitsViewController = .init()
    let statsInteractor: StatsInteractor = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      statsInteractor.connectSearcher(searcher)
      searcher.search()
      setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
    
    func setupUI() {
      view.backgroundColor = .white
      navigationItem.searchController = searchController
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.showsSearchResultsController = true
      searchController.automaticallyShowsCancelButton = false
    }
        
  }
  
}

/**
 Well done, now stats interactor receives the search statistics data. However it shoes them nowhere. Let's fix that!
 To make it simple, we will present hits count as the title of the view controller. Perhaps it's not the best place to show it in the interface, but this prevents putting to much layout-related code in this tutorial.
 Stats interactor present its data in the component implementing `StatsTextController` protocol.
 Make your view controller conform to this protocol by adding an extension. Now the view controller can be connected to the stats interactor with the corresponding method. Add this connection in the `viewDidLoad` method.
 */

extension GettingStartedGuide.StepFive {
 
  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsTableViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsTableViewController)
    let hitsTableViewController: BestBuyHitsViewController = .init()
    let statsInteractor: StatsInteractor = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      statsInteractor.connectSearcher(searcher)
      statsInteractor.connectController(self)
      searcher.search()
      setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
    
    func setupUI() {
      view.backgroundColor = .white
      navigationItem.searchController = searchController
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.showsSearchResultsController = true
      searchController.automaticallyShowsCancelButton = false
    }
        
  }

}

extension GettingStartedGuide.StepFive.ViewController: StatsTextController {
  
  func setItem(_ item: String?) {
    title = item
  }

}

/**
 Build and run your application: on each keystroke the updated search results count is shown. Now you have an idea of how InstantSearch modules are organized.
 - Each module has an `Interactor` containing a business-logic of the module.
 - Each `Interactor` has a corresponding `Controller` protocol defining the interaction with a UI component.
 `InstantSearch` provides a few basic implementations of `Controller` protocol for `UIKit` components such as `HitsTableViewController` (which we use in this tutorial), `TextFieldController`, `ActivityIndicatorController`. Feel free to use them to discover the abilities of `InstantSearch` with minimal effort. In your own project you might want implement more custom UI and behaviour. So, it's up to you to create an implementations of `Controller` protocol and to connect them to a corresponding interactors.
 */

/** ## Filter your results: RefinementList
  With your app, you can search more than 10000 products. However, you don’t want to scroll to the bottom of the list to find the exact product you’re looking for. We can more accurately filter our results by making use of the RefinementList components. We’ll build a filter that allows us to filter products by their category.
  First of all, add a FilterState. This component provide a convenient way to manage the state of your filters. In our case, we will add one refinement attribute: `category`. Finally we have to add the `RefinementList` components to other components in our search experience, such as `FacetListConnector`, `FacetListTableController` and `UITableViewController`. The `UITableViewController` will actually present a facet list. As a result, property definitions of your `ViewController` must look like this:
 */

extension GettingStartedGuide.StepSix {
  
  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsViewController,
                                                                              filterState: filterState)
    let hitsViewController: BestBuyHitsViewController = .init()
    let statsInteractor: StatsInteractor = .init()
    let filterState: FilterState = .init()
    lazy var categoryConnector: FacetListConnector = .init(searcher: searcher,
                                                           filterState: filterState,
                                                           attribute: "category",
                                                           operator: .and,
                                                           controller: categoryListController)
    
    lazy var categoryListController: FacetListTableController = .init(tableView: categoryTableViewController.tableView)
    let categoryTableViewController: UITableViewController = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      categoryConnector.connect()
      statsInteractor.connectSearcher(searcher)
      statsInteractor.connectController(self)
      searcher.search()
      setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
    
    func setupUI() {
      view.backgroundColor = .white
      navigationItem.searchController = searchController
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.showsSearchResultsController = true
      searchController.automaticallyShowsCancelButton = false
    }
        
  }

}

extension GettingStartedGuide.StepSix.ViewController: StatsTextController {
  
  func setItem(_ item: String?) {
    title = item
  }
  
}

/**
 Finally in the `setupUI()` method setup a navigation bar button item which will trigger the presentation of facet list and set the title of this list.
 Add `showFilters` and `dismissFilters` functions responsible for the presentation and dismiss logic of the facet list.
 */

extension GettingStartedGuide.StepSeven {
  
  class ViewController: UIViewController {
        
    let searcher = SingleIndexSearcher(appID: "latency",
                                       apiKey: "1f6fd3a6fb973cb08419fe7d288fa4db",
                                       indexName: "bestbuy")
    lazy var searchController: UISearchController = .init(searchResultsController: hitsViewController)
    lazy var searchConnector: SingleIndexSearchConnector<BestBuyItem> = .init(searcher: searcher,
                                                                              searchController: searchController,
                                                                              hitsInteractor: .init(),
                                                                              hitsController: hitsViewController,
                                                                              filterState: filterState)
    let hitsViewController: BestBuyHitsViewController = .init()
    let statsInteractor: StatsInteractor = .init()
    let filterState: FilterState = .init()
    lazy var categoryConnector: FacetListConnector = .init(searcher: searcher,
                                                           filterState: filterState,
                                                           attribute: "category",
                                                           operator: .and,
                                                           controller: categoryListController)
    
    lazy var categoryListController: FacetListTableController = .init(tableView: categoryTableViewController.tableView)
    let categoryTableViewController: UITableViewController = .init()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      searchConnector.connect()
      categoryConnector.connect()
      statsInteractor.connectSearcher(searcher)
      statsInteractor.connectController(self)
      searcher.search()
      setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      searchController.searchBar.becomeFirstResponder()
    }
    
    func setupUI() {
      view.backgroundColor = .white
      navigationItem.searchController = searchController
      navigationItem.rightBarButtonItem = .init(title: "Category", style: .plain, target: self, action: #selector(showFilters))
      searchController.hidesNavigationBarDuringPresentation = false
      searchController.showsSearchResultsController = true
      searchController.automaticallyShowsCancelButton = false
      categoryTableViewController.title = "Category"
    }
    
    @objc func showFilters() {
      let navigationController = UINavigationController(rootViewController: categoryTableViewController)
      categoryTableViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissFilters))
      present(navigationController, animated: true, completion: .none)
    }
    
    @objc func dismissFilters() {
      categoryTableViewController.navigationController?.dismiss(animated: true, completion: .none)
    }
    
  }

}

extension GettingStartedGuide.StepSeven.ViewController: StatsTextController {
  
  func setItem(_ item: String?) {
    title = item
  }
  
}

/**
 You can now build and run your application: you now have a search experience with filtering using the `RefinementList`!
 
 ## Going further
 Your users can enter a query, and your application shows them results as they type. It also provides a possibility to filter the results even further using `RefinementList`. That is pretty nice already! However, we can go further and improve on that.
 You can have a look at our examples to see more complex examples of applications built with `InstantSearch`.
 You can head to our components page to see other components that you could use.
*/
