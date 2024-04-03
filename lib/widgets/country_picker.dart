import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart' as p;
import 'package:storyapp/widgets/edit_text.dart';
import 'package:storyapp/widgets/text_view.dart';

import '../constants/app_colors.dart';
import '../data/countries.dart';

typedef CountryChange = void Function(Country country);

class CountryPicker extends StatelessWidget {
  final Country? value;
  final CountryChange onChanged;
  final String languageCode;
  const CountryPicker({
    super.key,
    this.value,
    required this.onChanged,
    this.languageCode = 'en',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextView(
              "Country",
              textColor: AppColors.primaryColor,
              fontSize: 16,
            ),
            const SizedBox(width: 10),
            if (value != null) ...[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/flags/${value!.alpha2Code!.toLowerCase()}.png',
                      width: 32,
                    ),
                    const SizedBox(width: 10),
                    TextView(
                      "${value?.name}",
                      textColor: AppColors.primaryColor,
                      fontSize: 16,
                      textAlign: TextAlign.end,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ] else ...[
              const TextView(
                "Select country",
                textColor: Colors.grey,
                fontSize: 16,
                textAlign: TextAlign.end,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context) async {
    final country = await showDialog<Country?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CountryPickerList(
              languageCode: languageCode,
            );
          },
        );
      },
    );
    if (country != null) {
      onChanged(country);
    }
  }
}

class CountryPickerList extends StatefulWidget {
  final String languageCode;

  const CountryPickerList({
    super.key,
    required this.languageCode,
  });

  @override
  State<CountryPickerList> createState() => _CountryPickerListState();
}

class _CountryPickerListState extends State<CountryPickerList> {
  late List<Country> filteredCountries = countries.toList();

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 40.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: EditText(
              hint: "Search country",
              onChanged: (value) {
                filteredCountries = countries.stringSearch(value)
                  ..sort(
                    (a, b) => a
                        .localizedName(widget.languageCode)
                        .compareTo(b.localizedName(widget.languageCode)),
                  );
                if (mounted) setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredCountries.length,
              itemBuilder: (ctx, index) => Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset(
                      'assets/flags/${filteredCountries[index].alpha2Code!.toLowerCase()}.png',
                      width: 32,
                    ),
                    title: TextView(
                      filteredCountries[index]
                          .localizedName(widget.languageCode),
                    ),
                    trailing: TextView(
                      filteredCountries[index].code,
                    ),
                    onTap: () {
                      Navigator.of(context).pop(filteredCountries[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef OnInputFormatted<T> = void Function(T value);

/// [AsYouTypeFormatter] is a custom formatter that extends [TextInputFormatter]
/// which provides as you type validation and formatting for phone number inputted.
class AsYouTypeFormatter extends TextInputFormatter {
  /// Contains characters allowed as seperators.
  final RegExp separatorChars = RegExp(r'[^\d]+');

  /// The [allowedChars] contains [RegExp] for allowable phone number characters.
  final RegExp allowedChars = RegExp(r'[\d+]');

  final RegExp bracketsBetweenDigitsOrSpace =
      RegExp(r'(?![\s\d])([()])(?=[\d\s])');

  /// The [isoCode] of the [Country] formatting the phone number to
  final String isoCode;

  /// The [dialCode] of the [Country] formatting the phone number to
  final String dialCode;

  /// [onInputFormatted] is a callback that passes the formatted phone number
  final OnInputFormatted<TextEditingValue> onInputFormatted;

  AsYouTypeFormatter(
      {required this.isoCode,
      required this.dialCode,
      required this.onInputFormatted});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int oldValueLength = oldValue.text.length;
    int newValueLength = newValue.text.length;

    if (newValueLength > 0 && newValueLength > oldValueLength) {
      String newValueText = newValue.text;
      String rawText = newValueText.replaceAll(separatorChars, '');
      String textToParse = dialCode + rawText;

      final _ = newValueText
          .substring(
              oldValue.selection.start == -1 ? 0 : oldValue.selection.start,
              newValue.selection.end == -1 ? 0 : newValue.selection.end)
          .replaceAll(separatorChars, '');

      formatAsYouType(input: textToParse).then(
        (String? value) {
          String parsedText = parsePhoneNumber(value);

          int offset =
              newValue.selection.end == -1 ? 0 : newValue.selection.end;

          if (separatorChars.hasMatch(parsedText)) {
            String valueInInputIndex = parsedText[offset - 1];

            if (offset < parsedText.length) {
              int offsetDifference = parsedText.length - offset;

              if (offsetDifference < 2) {
                if (separatorChars.hasMatch(valueInInputIndex)) {
                  offset += 1;
                } else {
                  bool isLastChar;
                  try {
                    var _ = newValueText[newValue.selection.end];
                    isLastChar = false;
                  } on RangeError {
                    isLastChar = true;
                  }
                  if (isLastChar) {
                    offset += offsetDifference;
                  }
                }
              } else {
                if (parsedText.length > offset - 1) {
                  if (separatorChars.hasMatch(valueInInputIndex)) {
                    offset += 1;
                  }
                }
              }
            }

            onInputFormatted(
              TextEditingValue(
                text: parsedText,
                selection: TextSelection.collapsed(offset: offset),
              ),
            );
          }
        },
      );
    }
    return newValue;
  }

  /// Accepts [input], unformatted phone number and
  /// returns a [Future<String>] of the formatted phone number.
  Future<String?> formatAsYouType({required String input}) async {
    try {
      String? formattedPhoneNumber = await p.PhoneNumberUtil.formatAsYouType(
        input,
        isoCode,
      );
      return formattedPhoneNumber;
    } on Exception {
      return '';
    }
  }

  /// Accepts a formatted [phoneNumber]
  /// returns a [String] of `phoneNumber` with the dialCode replaced with an empty String
  String parsePhoneNumber(String? phoneNumber) {
    final filteredPhoneNumber =
        phoneNumber?.replaceAll(bracketsBetweenDigitsOrSpace, '');

    if (dialCode.length > 4) {
      if (isPartOfNorthAmericanNumberingPlan(dialCode)) {
        String northAmericaDialCode = '+1';
        String countryDialCodeWithSpace =
            '$northAmericaDialCode ${dialCode.replaceFirst(northAmericaDialCode, '')}';

        return filteredPhoneNumber!
            .replaceFirst(countryDialCodeWithSpace, '')
            .replaceFirst(separatorChars, '')
            .trim();
      }
    }
    return filteredPhoneNumber!.replaceFirst(dialCode, '').trim();
  }

  /// Accepts a [dialCode]
  /// returns a [bool], true if the `dialCode` is part of North American Numbering Plan
  bool isPartOfNorthAmericanNumberingPlan(String dialCode) {
    return dialCode.contains('+1');
  }
}
