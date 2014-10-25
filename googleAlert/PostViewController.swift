//
//  PostViewController.swift
//  googleAlert
//
//  Created by naoyashiga on 2014/10/16.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var postLink: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スワイプジェスチャー
        let swipeRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target:self, action:Selector("swipe:"))
        //スワイプの方向
        swipeRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        //スワイプを検知する指の本数
        swipeRecognizer.numberOfTouchesRequired = 1
        //viewに追加
        self.view.addGestureRecognizer(swipeRecognizer)
        
        
        let url: NSURL = NSURL(string: postLink)
        let request: NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        webView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }
    
    func swipe(gesture: UISwipeGestureRecognizer){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

}
