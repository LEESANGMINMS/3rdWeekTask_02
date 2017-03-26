//
//  ViewController.swift
//  3rdWeek_CollectionViewMemo
//
//  Created by sang minlee on 2017. 3. 26..
//  Copyright © 2017년 LeeSangMin.house. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var controller: NSFetchedResultsController<Article>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = UICollectionViewCell()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        //        cell.imageView.image = image
        //        cell.label.text = String(indexPath.row)
        let article = controller.object(at: indexPath)
        
        cell.titleLabel?.text = article.title
        cell.imageView?.image = UIImage(data: article.image! as? NSData as! Data)
        
        
        // Configure the cell
        
        return cell
    }
    
    func fetchArticles() {
        //TODO : should implement
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        let dataSort = NSSortDescriptor(key:"createdAt",ascending:false)
        fetchRequest.sortDescriptors = [dataSort]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest, managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil
        )
        self.controller = controller
        self.controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath{
                collectionView.insertItems(at: [indexPath])
            }
            break
        case .delete:
            if let indexPath = indexPath{
                collectionView.deleteItems(at: [indexPath])
            }
            break
        case .update:
            if let indexPath = indexPath{
                let article = self.controller.object(at: indexPath)
                let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell.titleLabel?.text = article.title
            }
            break
        default:
            break
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detail" {
            let detailViewController: DetailViewController = segue.destination as! DetailViewController
            
            let article = controller.object(at: (collectionView.indexPathsForSelectedItems?.first!)!)
            detailViewController.article = article
            
        }
    }
    
    
    
}





