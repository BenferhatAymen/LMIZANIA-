import 'package:flutter/material.dart';
import 'package:lmizania/colors.dart';

class DepositAlertDialog extends StatelessWidget {
  DepositAlertDialog(
      {super.key,
      this.onSave,
      this.title = "Deposit",
      this.onChanged,
      this.validator});
  VoidCallback? onSave;
  Function(String)? onChanged;
  String title;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    var media = MediaQuery.sizeOf(context);
    return Form(
      key: formKey,
      child: AlertDialog(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: TColor.themeColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: TColor.themeColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 60,
                padding: EdgeInsets.zero,
                width: media.width * 0.9,
                child: TextFormField(
                  validator: validator,
                  keyboardType: TextInputType.number,
                  onChanged: onChanged,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12, top: 20),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                    ),
                    suffixIcon: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "DA ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onSave!();
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Note",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "The deposit you make will be deducted from your total balance",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
