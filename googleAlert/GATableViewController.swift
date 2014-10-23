//
//  GATableViewController.swift
//  googleAlert
//
//  Created by naoyashiga on 2014/10/15.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class GATableViewController: UITableViewController,NSXMLParserDelegate {

    var parser: NSXMLParser = NSXMLParser()
    var posts: [Post] = []
    var postTitle: String = String()
    var postLink: String = String()
    var postDate: String = String()
    var eName: String = String()
//    var attribute: Dictionary = Dictionary<NSObject,AnyObject>()
    var attribute: [NSObject:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let query: String = "ヤフー"
        let encodedQuery: String = query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        println(encodedQuery)
        
        let feed = "https://news.google.com/news/feeds?hl=ja&ned=us&ie=UTF-8&oe=UTF-8&output=atom&q=" + encodedQuery
        let url:NSURL = NSURL(string: feed)
            parser = NSXMLParser(contentsOfURL: url)
            parser.delegate = self
            parser.parse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return posts.count
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]) {
        eName = elementName
        attribute = attributeDict
        
        if elementName == "entry"{
            postTitle = String()
            postLink = String()
            postDate = String()
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(!data.isEmpty){
            if eName == "title"{
                postTitle += data
            }else if eName == "link"{
                postLink += data
            }else if eName == "updated"{
                postDate += data
            }
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if attribute["href"] != nil{
            postLink = attribute["href"] as NSString!
        }
        if elementName == "entry"{
            let post: Post = Post()
            post.postTitle = postTitle
            post.postLink = postLink
            post.postDate = postDate
            
            posts.append(post)
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomCell

        // Configure the cell...
        let post:Post = posts[indexPath.row]
        
        var titleSize: CGSize = CGSizeMake(self.view.bounds.width * 0.5, 30)
        
        //タイトルと配信サイトを分ける
        var titleArray = post.postTitle.componentsSeparatedByString(" - ")
        var title = titleArray[0]
        var siteName = titleArray[1]
        
        
        cell.titleLabel.sizeThatFits(titleSize)
        cell.titleLabel.text = title
        cell.titleLabel.sizeToFit()
        
        cell.siteNameLabel.text = siteName
        cell.dateLabel.text = post.postDate

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewpost"{
            //タッチしたポスト
            let selectedRow = tableView.indexPathForSelectedRow()?.row
            let post: Post = posts[selectedRow!]
            //行き先のview
            let viewController = segue.destinationViewController as PostViewController
            //urlを渡す
            viewController.postLink = post.postLink
            
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
