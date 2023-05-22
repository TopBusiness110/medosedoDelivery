import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/controller/chat_controller.dart';
import 'package:medosedoDelivery/controller/splash_controller.dart';
import 'package:medosedoDelivery/data/model/response/chat_model.dart';
import 'package:medosedoDelivery/utill/app_constants.dart';
import 'package:medosedoDelivery/view/screens/chat/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:medosedoDelivery/helper/date_converter.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/styles.dart';
import 'package:medosedoDelivery/view/base/custom_image.dart';
import 'package:medosedoDelivery/view/base/custom_ink_well.dart';

class ConversationItemCardWidget extends StatelessWidget {
  final Chat chat;
  const ConversationItemCardWidget({Key key, this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (chatController) {

        String basUrl =  chatController.userTypeIndex == 0?
        Get.find<SplashController>().baseUrls.shopImageUrl??'':
        Get.find<SplashController>().baseUrls.customerImageUrl??'';

        String image = chatController.userTypeIndex == 0?  chat.sellerInfo != null ?
        chat.sellerInfo.shops[0].image??'':'':chatController.userTypeIndex == 1? chat.customer?.image?? '':
        Get.find<SplashController>().configModel.companyLogo;

        String name = chatController.userTypeIndex == 0?   chat.sellerInfo != null ?
        chat.sellerInfo.shops[0].name :'Shop not found' :
        chatController.userTypeIndex == 1?chat.customer.fName + ' ' +chat.customer.lName:AppConstants.companyName;

        int userId = chatController.userTypeIndex == 0?  chat.sellerId : chat.userId;

        String path = '$basUrl/$image';

        return Container(
          margin:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5),width: .35),

            color: chat.seenBymedosedoDelivery == 1? Theme.of(context).cardColor : Theme.of(context).primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeOverLarge),
            boxShadow: [BoxShadow(color:Get.isDarkMode? Theme.of(context).primaryColor.withOpacity(.5) : Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
          ),
          child: CustomInkWell(
            onTap: () => Get.to(ChatScreen(userId: userId, name: name)),

            highlightColor: Theme.of(context).backgroundColor.withOpacity(0.1),
            radius: Dimensions.paddingSizeSmall,

            child: Stack(children: [
              Padding(
                padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(children: [
                   ClipOval(
                    child: CustomImage(
                      height: 50, width: 50,fit: BoxFit.cover,
                      image: path,
                    ),
                  ),
                   SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                     Text(name, style: rubikMedium.copyWith(
                         color: chatController.userTypeIndex == 0 && chat.sellerInfo == null ?
                         Colors.red :chatController.userTypeIndex == 1 && chat.customer == null ?  Colors.red : null)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(chat.message,
                            maxLines: 1,overflow: TextOverflow.ellipsis,
                            style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          ),
                        ),
                         SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(timeago.format(DateConverter.isoStringToLocalDate(chat.createdAt)),
                          style: rubikRegular.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeExtraSmall),),
                      ],
                    ),
                  ])),
                ]),
              ),



            ]),
          ),
        );
      }
    );
  }
}
