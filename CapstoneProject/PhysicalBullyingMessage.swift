//
//  PhysicalBullyingMessage.swift
//  CapstoneProject
//
//  Created by User on 4/1/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Member
{
	let name: String
	let color: UIColor
}

struct Message
{
	let member: Member
	let text: String
	let messageId: String
}

extension Message: MessageType
{
	var sender: Sender {
		return Sender(id: member.name, displayName: member.name)
	}
	
	var sentDate: Date {
		return Date()
	}
	
	var kind: MessageKind {
		return .text(text)
	}
}
