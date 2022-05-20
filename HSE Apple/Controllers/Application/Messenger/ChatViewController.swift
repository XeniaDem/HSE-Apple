//
//  ChatViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 09.02.2022.
//
 
import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
    public var isNewConversaion = false

    private var messages = [Message]()

    private let selfSender = Sender(photoURL: "", senderId: "1", displayName: "Joe Smith")


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        messageInputBar.inputTextView.becomeFirstResponder()
        navigationItem.title = "Ksenia Demidenko"
        navigationItem.largeTitleDisplayMode = .never


        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self


        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello!")))
        messages.append(Message(sender: selfSender, messageId: "3", sentDate: Date(), kind: .text("How are you?")))

        messageInputBar.delegate = self
        showMessageTimestampOnSwipeLeft = true

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }


}
extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }


}
extension ChatViewController : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        // Send Message
        if isNewConversaion {
            // create conv in database
        } else {
            //append to the same conv
        }
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text(text)))
        inputBar.inputTextView.text = nil
        messagesCollectionView.reloadDataAndKeepOffset()


    }
}
