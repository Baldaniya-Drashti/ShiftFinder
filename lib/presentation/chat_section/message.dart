import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/chat_section/message/message_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

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
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: 'Messages',
            ),
            body: PaginatedListView(
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
              refreshController: context.read<MessageBloc>().refreshController,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                ),
                itemBuilder: (context, index) => BaseText(
                  text: state.messageList[index].message ?? "",
                  fontSize: 14,
                  textColor: state.messageList[index].receiverId == receiverId
                      ? AppColors.red
                      : AppColors.black,
                ),
                itemCount: state.messageList.length,
              ),
            ),
            bottomSheet: textFiled(context: context, state: state),
          );
        },
      ),
    );
  }

  Widget textFiled(
      {required BuildContext context, required MessageState state}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(20),
      ),
      child: CustomTextField(
        controller: state.messageController,
        hintText: 'Type here',
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
                child: Icon(Icons.send),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
