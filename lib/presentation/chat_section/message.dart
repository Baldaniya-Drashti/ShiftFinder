import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shift/application/chat_section/message/message_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/chat_section/widget/chat_date_method.dart';
import 'package:shift/presentation/chat_section/widget/message_appbar.dart';
import 'package:shift/presentation/chat_section/widget/message_tile.dart';
import 'package:shift/presentation/chat_section/widget/show_date_widget.dart';
import 'package:shift/presentation/common/utils/image_picker_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/image_chosser.dialog.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:sticky_headers/sticky_headers.dart';

@RoutePage(name: 'message')
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
              appBar: MessageAppbar(
                additionalData: state.additional_data,
              ),
              body: state.isLoading
                  ? CenterLoadingIndicator(
                      isOnlyLoader: true,
                    )
                  : PaginatedListView(
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
                      isNoDataFound: state.messageList.isEmpty,
                      child: ListView.separated(
                        shrinkWrap: true,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: getSize(15)),
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
                                            state.messageList[index]
                                                    .createdAt ??
                                                0),
                                        DateTime.fromMillisecondsSinceEpoch(
                                          state.messageList[index + 1]
                                                  .createdAt ??
                                              0,
                                        )))
                                    : true)
                                ? ShowDateWidget(
                                    date:
                                        state.messageList[index].createdAt ?? 0,
                                  )
                                : SizedBox.shrink(),
                            content: MessageTile(
                              message: state.messageList[index],
                              // isSender: false,
                              isSender: state.messageList[index].receiverId ==
                                  receiverId,
                            ),
                          );
                        },
                        itemCount: state.messageList.length,
                      ),
                    ),
              bottomSheet: SafeArea(
                child: state.additional_data.status == true
                    ? textFiled(
                        context: context,
                        state: state,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getSize(44),
                              horizontal: getSize(20),
                            ),
                            child: Center(
                              child: BaseText(
                                text: StringConstant.youCanT,
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
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
          child: GestureDetector(
            onTap: () {
              ImageChooserDialog().showImageChooserDialog(
                takePhotoCallback: () async {
                  try {
                    String path = await ImagePickerUtils().pickImage(
                            imageSource: ImageSource.camera,
                            context: context) ??
                        '';
                    if (path.isNotEmpty) {
                      context.read<MessageBloc>().add(
                            MessageEvent.getDocumentLink(
                              path,
                              2,
                              '',
                            ),
                          );

                      print("CAMERA IMAGE PATH: $path");
                    }
                  } catch (e) {
                    print("Camera picker catch errorr---> $e");
                  }
                },
                selectPhotoCallback: () async {
                  String path = await ImagePickerUtils().pickImage(
                        imageSource: ImageSource.gallery,
                        context: context,
                      ) ??
                      '';

                  if (path.isNotEmpty) {
                    context.read<MessageBloc>().add(
                          MessageEvent.getDocumentLink(
                            path,
                            2,
                            '',
                          ),
                        );
                    print("GALLERY IMAGE PATH: $path");
                  }
                },
                selectPdfCallback: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'pdf',
                    ],
                  );
                  if (result?.files.first.path?.isNotEmpty ?? false) {
                    context.read<MessageBloc>().add(
                          MessageEvent.getDocumentLink(
                            result?.files.first.path ?? '',
                            4,
                            result?.files.first.name ?? '',
                          ),
                        );
                    print("Video PATH: ${result?.files.first.path}");
                  }
                },
                selectVideoCallback: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.video,
                  );
                  if (result?.files.first.path?.isNotEmpty ?? false) {
                    context.read<MessageBloc>().add(
                          MessageEvent.getDocumentLink(
                            result?.files.first.path ?? '',
                            3,
                            '',
                          ),
                        );
                    print("Video PATH: ${result?.files.first.path}");
                  }
                },
                context: context,
              );
            },
            child: SvgPicture.asset(
              SvgImageConstant.plus,
              colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),
            ),
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
