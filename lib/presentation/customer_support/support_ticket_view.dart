import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/consumer_support/support_ticket/support_ticket_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/common_country_code_picker.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/attachment.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_country_code_removing_formatter.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/customer_support/support_ticket_layout.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../common/widgets/base_text.dart';

@RoutePage(name: "SupportTicketView")
class SupportTicketView extends StatelessWidget {
  const SupportTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFocus.unfocus(context);
      },
      child: BlocProvider(
        create: (context) => getIt<SupportTicketBloc>()
          ..add(SupportTicketEvent.fetchLocationList(context: context)),
        child: Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: StringConstant.submitATicket,
          ),
          body: _SupportForm(),
        ),
      ),
    );
  }
}

class _SupportForm extends StatefulWidget {
  const _SupportForm();

  @override
  State<_SupportForm> createState() => _SupportFormState();
}

class _SupportFormState extends State<_SupportForm> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportTicketBloc, SupportTicketState>(
      builder: (context, state) {
        final role = getCurrentRole();
        if (state.loading) return CenterLoadingIndicator();
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(getSize(15)),
                children: [
                  SupportTicketFormLayout(
                    title: StringConstant.contactInformation,
                    children: [
                      if (role == 2) ...[
                        CustomTextField(
                          controller: _companyNameController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          hintText: StringConstant.companyName,
                          labelText: StringConstant.companyName,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                          ],
                          isLabelPadding: false,
                          textInputAction: TextInputAction.next,
                          validator: (value, context) {
                            value = value?.trim() ?? "";
                            if (value.isEmpty) {
                              return StringConstant.pleaseEnterCompanyName;
                            }
                            return null;
                          },
                        ),
                        LocationDropdown(
                          initialLocation: state.selectedLocation,
                          onLocationChanged: (LocationDTO location) {
                            context.read<SupportTicketBloc>().add(
                                SupportTicketEvent.onLocationChanged(
                                    selectedLocation: location));
                          },
                        ),
                      ],
                      CustomTextField(
                        controller: _nameController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText: StringConstant.name,
                        labelText: StringConstant.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]')),
                        ],
                        isLabelPadding: false,
                        textInputAction: TextInputAction.next,
                        validator: (value, context) {
                          value = value?.trim() ?? "";
                          if (value.isEmpty) {
                            return StringConstant.pleaseEnterYourName;
                          } else if (value.length <= 2 && value.length >= 32) {
                            return StringConstant.pleaseEnterValidName;
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: _emailAddressController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText: StringConstant.emailAddress,
                        labelText: StringConstant.emailAddress,
                        isLabelPadding: false,
                        textInputAction: TextInputAction.next,
                        validator: (value, context) {
                          value = value?.trim() ?? "";
                          const emailRegex =
                              r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
                          if (value.isEmpty) {
                            return StringConstant.pleaseEnterEmail;
                          } else if (!RegExp(emailRegex).hasMatch(value)) {
                            return StringConstant.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                      ),
                      BlocSelector<SupportTicketBloc, SupportTicketState,
                          String>(
                        selector: (state) => state.selectedCountryFlag,
                        builder: (context, selectedCountryFlag) {
                          return MobileNumberInputField(
                            controller: _mobileNumberController,
                            selectedCountry: selectedCountryFlag,
                            onCountrySelected: (country) {
                              context.read<SupportTicketBloc>().add(
                                    SupportTicketEvent.onCountrySelected(
                                        code: country.phoneCode,
                                        flag: country.flagEmoji),
                                  );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Gap(28),
                  SupportTicketFormLayout(
                    title: StringConstant.issueDetails,
                    children: [
                      CustomTextField(
                        controller: _subjectController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        labelText: StringConstant.subject,
                        hintText: StringConstant.typeHere,
                        maxLines: 2,
                        isLabelPadding: false,
                        textInputAction: TextInputAction.next,
                        validator: (value, context) {
                          value = value?.trim() ?? "";
                          if (value.isEmpty) {
                            return StringConstant.pleaseEnterSubject;
                          }

                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        hintText: StringConstant.typeHere,
                        labelText: StringConstant.description,
                        maxLines: 3,
                        isLabelPadding: false,
                        textInputAction: TextInputAction.done,
                        validator: (value, context) {
                          value = value?.trim() ?? "";
                          if (value.isEmpty) {
                            return StringConstant.pleaseEnterDescription;
                          }
                          return null;
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              BaseText(
                                text: StringConstant.attachment,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                fontWeight: FontWeight.w500,
                                textColor: Color(0xff030202),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: getSize(5)),
                                  child: BaseText(
                                    text: "(Optional)",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        AppColors.black.withValues(alpha: 0.8),
                                    fontFamily: "Roboto Flex",
                                  )),
                            ],
                          ),
                          Gap(getSize(10)),
                          BlocSelector<SupportTicketBloc, SupportTicketState,
                              String?>(
                            selector: (state) => state.path,
                            builder: (context, path) {
                              return AttachmentOption(
                                path: path,
                                onRemove: () {
                                  context.read<SupportTicketBloc>().add(
                                      SupportTicketEvent.onRemoveAttachment());
                                },
                                onSelected: (String path) {
                                  context.read<SupportTicketBloc>().add(
                                      SupportTicketEvent.onAttachmentSelected(
                                          path: path));
                                },
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Gap(28),
                  CommonButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) {
                        showError(
                                message: StringConstant
                                    .someDetailsAreMissingOrInvalidPleaseCheck)
                            .show(context);
                        return;
                      } else {
                        final selectedLocation = context
                            .read<SupportTicketBloc>()
                            .state
                            .selectedLocation;
                        if (selectedLocation == null && role == 2) {
                          showError(
                                  message: StringConstant.pleaseSelectLocation)
                              .show(context);
                          return;
                        }

                        context.read<SupportTicketBloc>().add(
                              SupportTicketEvent.onSubmit(
                                name: _nameController.text.trim(),
                                email: _emailAddressController.text.trim(),
                                subject: _subjectController.text.trim(),
                                description: _descriptionController.text.trim(),
                                companyName: _companyNameController.text.trim(),
                                phoneNumber:
                                    _mobileNumberController.text.trim(),
                                context: context,
                              ),
                            );
                      }
                    },
                    buttonText: StringConstant.submit,
                  )
                ],
              ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );
  }
}

class LocationDropdown extends StatelessWidget {
  const LocationDropdown({
    super.key,
    this.initialLocation,
    required this.onLocationChanged,
  });

  final LocationDTO? initialLocation;
  final void Function(LocationDTO locationId) onLocationChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportTicketBloc, SupportTicketState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              text: StringConstant.locationAddress,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Gap(8),
            Material(
              color: (state.selectedLocation != null)
                  ? AppColors.white
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomLocationDropdDown(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    items: state.locationList.map(
                      (e) {
                        return DropdownMenuItem<LocationDTO>(
                          value: e,
                          child: BaseText(
                            text: e.location ?? "",
                            fontSize: 14,
                            maxLines: 1,
                          ),
                        );
                      },
                    ).toList(),
                    hintText: StringConstant.locationAddress,
                    onChanged: (value) {
                      final location = value as LocationDTO?;
                      if (location != null) onLocationChanged(location);
                    },
                    showDropDown: false,
                    showTextfield: false,
                    validator: (value) {
                      print("fvjvjdnj---> ${state.selectedLocation}");
                      if (state.selectedLocation == null) {
                        return StringConstant.pleaseSelectLocation;
                      }
                      return null;
                    },
                  ),
                  /*  CustomDropdownField<LocationDTO>(
                    hintText: StringConstant.locationAddress,
                    value: initialLocation,
                    radius: 10,
                    hintTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black.withValues(alpha: 0.5),
                    ),
                    items: state.locationList.map(
                      (e) {
                        return DropdownMenuItem<LocationDTO>(
                          value: e,
                          child: BaseText(
                            text: e.location ?? "",
                            fontSize: 14,
                            maxLines: 1,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      final location = value as LocationDTO?;
                      if (location != null) onLocationChanged(location);
                    },
                    // validator: (value) {
                    //   value = value?.trim() ?? "";
                    //   if (value.isEmpty) {
                    //     return StringConstant.pleaseSelectLocation;
                    //   }
                    //   return null;
                    // },
                  ),
                  if (!isValidate && state.selectedLocation == null)
                    commonErrorText(StringConstant.pleaseSelectLocation), */
                  if (state.selectedLocation != null) ...[
                    Divider(height: 0),
                    Padding(
                      padding: const EdgeInsets.all(14.0).copyWith(top: 12),
                      child: BaseText(
                        text: state.selectedLocation?.facility_type?.name ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class MobileNumberInputField extends StatelessWidget {
  const MobileNumberInputField({
    super.key,
    required this.controller,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  final TextEditingController controller;
  final String selectedCountry;
  final void Function(Country country) onCountrySelected;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      isOptional: true,
      labelText: StringConstant.phoneNumber,
      hintText: StringConstant.phoneNumber,
      keyboardType: TextInputType.phone,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      isLabelPadding: false,
      maxLength: 10,
      errorMaxLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CountryCodeRemovingFormatter(),
      ],
      prefixIcon: CommonCountryCodePicker(
        initialSelection: selectedCountry,
        onChanged: onCountrySelected,
      ),
      validator: (value, context) {
        value = value?.trim() ?? "";
        if (value.isNotEmpty) {
          if (value.length < 10) {
            return StringConstant.phoneNumberShouldBeBetween10And15Digits;
          }
        }
        return null;
      },
    );
  }
}
