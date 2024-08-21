import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/chat_section/chat/chat_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage(name: 'chat')
class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.chat,
      ),
      body: BlocProvider(
        create: (context) => getIt<ChatBloc>()
          ..add(
            ChatEvent.getChatList(true),
          ),
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {},
          builder: (context, state) {
            return !state.isLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(20),
                      vertical: getSize(25),
                    ),
                    child: PaginatedListView(
                      onRefresh: () {
                        context
                            .read<ChatBloc>()
                            .add(ChatEvent.getChatList(true));
                      },
                      onLoading: () {
                        context
                            .read<ChatBloc>()
                            .add(ChatEvent.getChatList(false));
                      },
                      refreshController:
                          context.read<ChatBloc>().refreshController,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: getSize(15)),
                        itemCount: state.chatList.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return chatTile(
                            index: index,
                            state: state,
                            onTap: () {
                              context.router
                                  .push(
                                PageRouteInfo(
                                  Message.name,
                                  args: MessageArgs(
                                    receiverId:
                                        state.chatList[index].userId ?? 0,
                                  ),
                                ),
                              )
                                  .then((value) {
                                if ((state.chatList[index].count ?? 0) > 0) {
                                  context
                                      .read<ChatBloc>()
                                      .add(ChatEvent.getChatList(true));
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  )
                : CenterLoadingIndicator(
                    isOnlyLoader: true,
                  );
          },
        ),
      ),
    );
  }

  Widget chatTile(
      {required int index, required ChatState state, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          getSize(5),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getSize(8),
          ),
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(width: getSize(12)),
                  profileImage(imageUrl: state.chatList[index].image),
                  SizedBox(width: getSize(10)),
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        Expanded(
                          child: BaseText(
                            text: state.chatList[index].userName ?? '',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: getSize(5)),
                          child: badges.Badge(
                            onTap: () {},
                            showBadge: ((state.chatList[index].count ?? 0) > 0),
                            badgeContent: BaseText(
                              text: "${state.chatList[index].count ?? 0}",
                              textColor: AppColors.white,
                              fontSize: 8,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: AppColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(SvgImageConstant.next),
                  SizedBox(
                    width: getSize(10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profileImage({String? imageUrl}) {
    return Container(
      height: getSize(35),
      width: getSize(35),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor),
        image: DecorationImage(
          image: NetworkImage(
            imageUrl ??
                'https://dev.iroidsolutions.com/shiftfinder-app-backend/public/storage/profile/6GD2ePUiKWPrCMzi3Y9A5sLML2RHcIiDc88YTHlu.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
