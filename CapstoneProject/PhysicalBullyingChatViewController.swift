//
//  PhysicalBullyingChatViewController.swift
//  CapstoneProject
//
//  Created by User on 3/26/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import Firebase
import FirebaseAuth
import FirebaseFirestore



class PhysicalBullyingChatViewController: MessagesViewController, MessagesDataSource
{
	let messages: [MessageType] = []
	var messageListener: ListenerRegistration?
	
	var user: Auth.auth().currentUser.uid
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
		
	}
	
	func currentSender() -> Sender {
		return Sender(id: "any_unique_id", displayName: "Steven")
	}
	
	func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
		return messages.count
	}
	
	func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
		return messages[indexPath.section]
	}











}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
