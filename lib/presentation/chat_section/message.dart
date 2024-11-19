import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/chat_section/message/message_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/chat_section/widget/chat_date_method.dart';
import 'package:shift/presentation/chat_section/widget/message_appbar.dart';
import 'package:shift/presentation/chat_section/widget/message_tile.dart';
import 'package:shift/presentation/chat_section/widget/show_date_widget.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:sticky_headers/sticky_headers.dart';

@RoutePage(
  name: 'message',
)
class Message extends StatelessWidget {
  final int receiverId;
  const Message({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MessageBloc>()
        ..add(
          MessageEvent.getReceiverId(receiverId),
        ),
      child: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: MessageAppbar(),
              // appBar: CommonAppBar(
              //   onBackPressed: () => context.router.maybePop(),
              //   title: 'Messages',
              // ),
              body: PaginatedListView(
                enablePullDown: false,
                reverse: true,
                onRefresh: () {
                  context.read<MessageBloc>().add(
                        MessageEvent.getMessageList(true),
                      );
                },
                onLoading: () {
                  context.read<MessageBloc>().add(
                        MessageEvent.getMessageList(false),
                      );
                },
                refreshController:
                    context.read<MessageBloc>().refreshController,
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: getSize(15),
                  ),
                  padding: EdgeInsets.only(
                    left: getSize(20),
                    right: getSize(20),
                    top: getSize(30),
                    bottom: getSize(100),
                  ),
                  itemBuilder: (context, index) {
                    return StickyHeader(
                      header: (index != (state.messageList.length - 1)
                              ? !(ChatDateMethod().isSameDay(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      state.messageList[index].createdAt ?? 0),
                                  DateTime.fromMillisecondsSinceEpoch(
                                    state.messageList[index + 1].createdAt ?? 0,
                                  ),
                                ))
                              : true)
                          ? ShowDateWidget(
                              date: state.messageList[index].createdAt ?? 0,
                            )
                          : SizedBox.shrink(),
                      content: MessageTile(
                        message: state.messageList[index],
                        isSender:
                            state.messageList[index].receiverId == receiverId,
                      ),
                    );
                  },
                  itemCount: state.messageList.length,
                ),
              ),
              bottomSheet: SafeArea(
                child: textFiled(
                  context: context,
                  state: state,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFiled(
      {required BuildContext context, required MessageState state}) {
    return Padding(
      // padding: EdgeInsets.symmetric(
      //   horizontal: getSize(20),
      //   vertical: getSize(25),
      // ),
      padding: EdgeInsets.only(
        left: getSize(20),
        right: getSize(20),
        bottom: getSize(25),
      ),
      child: CustomTextField(
        controller: state.messageController,
        hintText: 'Type here',
        prefixIconConstraints: BoxConstraints(
          // maxWidth: getSize(24),
          maxHeight: getSize(24),
          minWidth: getSize(24),
          minHeight: getSize(24),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: getSize(15),
            right: getSize(8),
          ),
          child: SvgPicture.asset(
            SvgImageConstant.plus,
            colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
        ),
        onChanged: (p0) => context.read<MessageBloc>().add(
              MessageEvent.messageChanged(p0),
            ),
        suffixIcon: state.message.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  context.read<MessageBloc>().add(
                        MessageEvent.sendMessage(),
                      );
                },
                child: sendButton(),
              )
            : SizedBox.shrink(),
      ),
    );
  }

  Widget sendButton() {
    return Container(
      margin: EdgeInsets.only(
        left: getSize(10),
      ),
      padding: EdgeInsets.all(getSize(8)),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(
          getSize(7),
        ),
      ),
      child: Image.asset(
        PngImageConstants.send,
        height: getSize(20),
        width: getSize(20),
      ),
    );
  }
}
