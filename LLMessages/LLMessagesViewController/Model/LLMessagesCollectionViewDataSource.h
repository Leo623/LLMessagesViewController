//
//  LLMessagesCollectionViewDataSource.h
//  LLMessages
//
//  Created by ruofei on 16/4/11.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LLMessagesCollectionView;
@protocol LLMessageData;
@protocol LLMessageBubbleImageDataSource;
@protocol LLMessageAvatarImageDataSource;


/**
 *  An object that adopts the `LLMessagesCollectionViewDataSource` protocol is responsible for providing the data and views
 *  required by a `LLMessagesCollectionView`. The data source object represents your app’s messaging data model
 *  and vends information to the collection view as needed.
 */
@protocol LLMessagesCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 *  Asks the data source for the current sender's display name, that is, the current user who is sending messages.
 *
 *  @return An initialized string describing the current sender to display in a `LLMessagesCollectionViewCell`.
 *
 *  @warning You must not return `nil` from this method. This value does not need to be unique.
 */
- (NSString *)senderDisplayName;

/**
 *  Asks the data source for the current sender's unique identifier, that is, the current user who is sending messages.
 *
 *  @return An initialized string identifier that uniquely identifies the current sender.
 *
 *  @warning You must not return `nil` from this method. This value must be unique.
 */
- (NSString *)senderId;

/**
 *  Asks the data source for the message data that corresponds to the specified item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return An initialized object that conforms to the `LLMessageData` protocol. You must not return `nil` from this method.
 */
- (id<LLMessageData>)collectionView:(LLMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the data source that the item at indexPath has been deleted.
 *  Implementations of this method should remove the item from the data source.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 */
- (void)collectionView:(LLMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the message bubble image data that corresponds to the specified message data item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return An initialized object that conforms to the `LLMessageBubbleImageDataSource` protocol. You may return `nil` from this method if you do not
 *  want the specified item to display a message bubble image.
 *
 *  @discussion It is recommended that you utilize `LLMessagesBubbleImageFactory` to return valid `LLMessagesBubbleImage` objects.
 *  However, you may provide your own data source object as long as it conforms to the `LLMessageBubbleImageDataSource` protocol.
 *
 *  @warning Note that providing your own bubble image data source objects may require additional
 *  configuration of the collectionView layout object, specifically regarding its `messageBubbleTextViewFrameInsets` and `messageBubbleTextViewTextContainerInsets`.
 *
 *  @see LLMessagesBubbleImageFactory.
 *  @see LLMessagesCollectionViewFlowLayout.
 */
- (id<LLMessageBubbleImageDataSource>)collectionView:(LLMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the avatar image data that corresponds to the specified message data item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A initialized object that conforms to the `LLMessageAvatarImageDataSource` protocol. You may return `nil` from this method if you do not want
 *  the specified item to display an avatar.
 *
 *  @discussion It is recommended that you utilize `LLMessagesAvatarImageFactory` to return valid `LLMessagesAvatarImage` objects.
 *  However, you may provide your own data source object as long as it conforms to the `LLMessageAvatarImageDataSource` protocol.
 *
 *  @see LLMessagesAvatarImageFactory.
 *  @see LLMessagesCollectionViewFlowLayout.
 */
- (id<LLMessageAvatarImageDataSource>)collectionView:(LLMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  Asks the data source for the text to display in the `cellTopLabel` for the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see LLMessagesCollectionViewCell.
 */
- (NSAttributedString *)collectionView:(LLMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `messageBubbleTopLabel` for the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see LLMessagesCollectionViewCell.
 */
- (NSAttributedString *)collectionView:(LLMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `cellBottomLabel` for the the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see LLMessagesCollectionViewCell.
 */
- (NSAttributedString *)collectionView:(LLMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

@end
