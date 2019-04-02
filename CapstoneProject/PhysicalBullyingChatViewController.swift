//
//  PhysicalBullyingChatViewController.swift
//  CapstoneProject
//
//  Created by User on 4/1/19.
//  Copyright © 2019 User. All rights reserved.
//
//credit: https://www.scaledrone.com/blog/ios-chat-tutorial/

import UIKit
import MessageKit
import MessageInputBar
import MessageUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

extension PhysicalBullyingChatViewController: MessagesDataSource {
	func numberOfSections(
		in messagesCollectionView: MessagesCollectionView) -> Int {
		return messages.count
	}
	
	func currentSender() -> Sender {
		return Sender(id: member.name, displayName: member.name)
	}
	
	func messageForItem(
		at indexPath: IndexPath,
		in messagesCollectionView: MessagesCollectionView) -> MessageType {
		
		return messages[indexPath.section]
	}
	
	func messageTopLabelHeight(
		for message: MessageType,
		at indexPath: IndexPath,
		in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		
		return 12
	}
	
	func messageTopLabelAttributedText(
		for message: MessageType,
		at indexPath: IndexPath) -> NSAttributedString? {
		
		return NSAttributedString(
			string: message.sender.displayName,
			attributes: [.font: UIFont.systemFont(ofSize: 12)])
	}
}

extension PhysicalBullyingChatViewController: MessagesLayoutDelegate {
	func heightForLocation(message: MessageType,
						   at indexPath: IndexPath,
						   with maxWidth: CGFloat,
						   in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		
		return 0
	}
}

extension PhysicalBullyingChatViewController: MessagesDisplayDelegate {
	func configureAvatarView(
		_ avatarView: AvatarView,
		for message: MessageType,
		at indexPath: IndexPath,
		in messagesCollectionView: MessagesCollectionView) {
		
		let message = messages[indexPath.section]
		let color = message.member.color
		avatarView.backgroundColor = color
	}
}

extension PhysicalBullyingChatViewController: MessageInputBarDelegate {
	func messageInputBar(
		_ inputBar: MessageInputBar,
		didPressSendButtonWith text: String) {
		
		let newMessage = Message(
			member: member,
			text: text,
			messageId: UUID().uuidString)
		
		messages.append(newMessage)
		inputBar.inputTextView.text = ""
		messagesCollectionView.reloadData()
		messagesCollectionView.scrollToBottom(animated: true)
	}
}

class PhysicalBullyingChatViewController: MessagesViewController
{
	var messages: [Message] = []
	var member: Member!
	
	@objc func goBack()
	{
		performSegue(withIdentifier: "physicalbullyingtomainchat", sender: nil)
		
	}
	
	func setUpNavBar()
	{
		let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
		self.view.addSubview(navBar)
		navBar.items?.append(UINavigationItem(title: "Physical Bullying Chat"))
		let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
		navBar.topItem?.leftBarButtonItem = backButton
	}
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		setUpNavBar()
		
        // Do any additional setup after loading the view.
		member = Member(name: "bluemoon", color: .blue)
		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messageInputBar.delegate = self
		messagesCollectionView.messagesDisplayDelegate = self
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
