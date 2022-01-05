import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/utils/constant.dart';

class SplitPaymentInputRow extends StatefulWidget {
  @override
  _SplitPaymentInputRowState createState() => _SplitPaymentInputRowState();
}

class _SplitPaymentInputRowState extends State<SplitPaymentInputRow> {
  final List<String> items = ['Cash', 'Online', 'Card', 'Credit'];
  String dropdownValue = 'Cash';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.4, color: Colors.black),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Align(
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                  iconSize: 35,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: items
                      .map((values) => DropdownMenuItem(
                            child: Text(
                              values,
                              style: TextStyle(fontSize: 16),
                            ),
                            value: values,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, bottom: 8),
                    alignLabelWithHint: true,
                    hintText: 'Amount',
                    labelStyle: TextStyle(color: kAccentColor),
                    labelText: 'Amount',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kAccentColor, width: 1),
                    ),
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {}),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          PrimaryButton(title: 'Pay', onPressed: () {}),
        ],
      ),
    );
  }
}
